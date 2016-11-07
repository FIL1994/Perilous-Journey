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
	public class EnemyExplosiveBullet extends Entity 
	{
		[Embed(source="../assets/bullet.png")]
		private const IMAGE:Class;
		private var _pathToFollow:Vector.<Point>;
         
        private var targetY:Number;
		private var _speed:Number;
		
		public function EnemyExplosiveBullet(x:Number, y:Number, speed:Number = 15, bulletSize:Number = 3, bulletColour:uint = Colours.RAVEN) 
		{
			var image:Image = new Image(new BitmapData(bulletSize, bulletSize, false, bulletColour));
			//graphic = new Image(image);
			graphic = image;
             
			this.x = x;
			this.y = y;
			
			targetY = y + MyGame.randRange(25, 45);
			
			_speed = speed;

			type = "enemyBullet";
			
			setHitboxTo(image);
			
		}
		
		override public function update():void 
		{
			if(y < targetY)
				y += _speed * FP.elapsed;
			else {
				MyGame.shotsAgainst += 9;
				world.add(new EnemyBullet(x, y, 35, 3, Colours.RUBY));
				world.add(new EnemyBullet(x, y + 5, 35, 3, Colours.RUBY));
				world.add(new EnemyBullet(x, y - 5, 35, 3, Colours.RUBY));
				
				world.add(new EnemyBullet(x + 3, y, 35, 3, Colours.RUBY, true, false));
				world.add(new EnemyBullet(x - 2, y, 35, 3, Colours.RUBY, true, false));
				world.add(new EnemyBullet(x - 7, y, 35, 3, Colours.RUBY, true, false));
				
				world.add(new EnemyBullet(x - 3, y, 35, 3, Colours.RUBY, true, true));
				world.add(new EnemyBullet(x + 2, y, 35, 3, Colours.RUBY, true, true));
				world.add(new EnemyBullet(x + 7, y, 35, 3, Colours.RUBY, true, true));
				
				destroy();
			}
				
            if (y >= 600 || x >= 700 || x<= -10)
            {                 
                destroy();
            }
			
		}
		
		public function destroy():void
        {
            graphic = null;
			world.remove(this);
        }
	}

}