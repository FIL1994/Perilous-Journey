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
	public class PlayerBullet extends Entity 
	{
		[Embed(source="../assets/bullet.png")]
		private const IMAGE:Class;
		private var _pathToFollow:Vector.<Point>;
         
        private var _xPos:Number;
        private var _yPos:Number;
		
		public function PlayerBullet(pathToFollow:Vector.<Point>, xPos:Number, yPos:Number) 
		{
			var image:Image = new Image(new BitmapData(3, 3, false, Colours.PINE));
			//graphic = new Image(image);
			graphic = image;
             
            graphic.x = graphic.y = -3.5;
             
            _pathToFollow = pathToFollow;
             
            _xPos = xPos;
            _yPos = yPos;
			type = "playerBullet";
			
			setHitbox(3, 3, x + 4, y + 4);
			
		}
		
		override public function update():void 
		{
			x = _xPos + _pathToFollow[0].x * FP.elapsed * 45;
            y = _yPos + _pathToFollow[0].y * FP.elapsed * 45;
             
            _pathToFollow.shift();
             
            if (_pathToFollow.length == 0)
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
            _pathToFollow = null;
             
            graphic = null;
        }
	}

}