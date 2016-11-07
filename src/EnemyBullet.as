package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import flash.geom.Point;
    import net.flashpunk.graphics.Image;
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Philip VR
	 */
	public class EnemyBullet extends Entity 
	{
		[Embed(source="../assets/bullet.png")]
		private const IMAGE:Class;
		private var _pathToFollow:Vector.<Point>;
		
		private var sideways:Boolean;
		private var goRight:Boolean;
         
        private var _xPos:Number;
        private var _yPos:Number;
		private var _speed:Number;
		
		public function EnemyBullet(xPos:Number, yPos:Number, speed:Number = 35, bulletSize:Number = 3, bulletColour:uint = Colours.FIRE_BRICK, sideways:Boolean = false, goRight:Boolean = false) 
		{
			var image:Image = new Image(new BitmapData(bulletSize, bulletSize, false, bulletColour));
			//graphic = new Image(image);
			graphic = image;
             
			x = xPos;
			y = yPos;
            _xPos = xPos;
            _yPos = yPos;
			
			this.sideways = sideways;
			this.goRight = goRight;
			
			_speed = speed;

			type = "enemyBullet";
			
			setHitboxTo(image);
			
		}
		
		override public function update():void 
		{			
			if(sideways){
				if(goRight)
					x += _speed * FP.elapsed;
				else
					x -= _speed * FP.elapsed;
            }
			else {
				y += _speed * FP.elapsed;
			}
				
            if (y >= 600 || x >= 700 || x<= -10)
            {
                world.remove(this);
                 
                destroy();
            }
			
		}
		
		public function destroy():void
        {
            graphic = null;
        }
	}

}