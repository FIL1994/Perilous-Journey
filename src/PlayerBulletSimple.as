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
	public class PlayerBulletSimple extends Entity 
	{
		[Embed(source="../assets/bullet.png")]
		private const IMAGE:Class;
		private var _pathToFollow:Vector.<Point>;
         
        private var xPos:Number;
        private var yPos:Number;
		private var speed:Number;
		
		private var goRight:Boolean;
		
		public function PlayerBulletSimple(xPos:Number, yPos:Number, speed:Number = 125, bulletSize:Number = 3, goRight:Boolean = true, bulletColour:uint = Colours.PINE) 
		{
			var image:Image = new Image(new BitmapData(bulletSize, bulletSize, false, bulletColour));
			//graphic = new Image(image);
			graphic = image;
             
			x = xPos;
			y = yPos;
            this.xPos = xPos;
            this.yPos = yPos;
			this.goRight = goRight;
			
			this.speed = speed;

			type = "playerBullet";
			
			setHitboxTo(image);
			
		}
		
		override public function update():void 
		{
			if(goRight)
				x += speed * FP.elapsed;
			else
				x -= speed * FP.elapsed;
             
            if (y >= 600 || x >= 700 || x<= -10)
            {
                world.remove(this);
                 
                destroy();
            }
			
			//bullets die when colliding with enemy
			if (collide("enemy", x, y) || collide("enemyBoss", x, y)) {
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