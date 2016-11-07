package enemies 
{
	import com.newgrounds.BitmapLoader;
	import flash.display.Bitmap;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import flash.geom.Point;
    import net.flashpunk.graphics.Image;
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Philip VR
	 */
	public class EnemyTwoShots extends Entity 
	{
		private const death:Sfx = new Sfx(Sounds.ENEMY_DEATH);
		
		[Embed(source="../../assets/enemies/2ShotEnemy.png")] private const ENEMY_SQUARE_GRAPHIC:Class;
		
		private var dx:Number = 0.001;
		private var dy:Number = 0.001;
		
		private var shoot:Boolean = false;
		private var frames:Number = 30;
		private var shootOnFrame:Number = 85;
		private var targetX:Number;
		private var startX:Number = -1;
		private var framesInOrigin:Number = 0;
		private var hasStarted:Boolean = false;
		private var goToStart:Boolean = true;
		private var enemyImage:Image;
		
		public function EnemyTwoShots(x:Number = 0, y:Number = 0, colour:uint = Colours.GHOST_WHITE) 
		{
			enemyImage = new Image(ENEMY_SQUARE_GRAPHIC);
			graphic = enemyImage
			
			enemyImage.color = colour;
			
			super(x, y, graphic, mask);
			this.x = x;
			this.y = y;
			setHitboxTo(graphic);
			
			type = "enemy";
			shootOnFrame = MyGame.randRange(100, 130);
			frames = MyGame.randRange(Number.floor(shootOnFrame - shootOnFrame / 1.5), shootOnFrame - 25);
		}
		
		public function destroy():void
        {
			MyGame.twoShotsDefeated++;
			death.play();		
            MyGame.score += 2;
            graphic = null;
			if(MyGame.enemyCount > 0){
				MyGame.enemyCount--;
			}
			trace("Enemy count: " + MyGame.enemyCount);
			FP.world.remove(this);
        }
		
		override public function update():void 
		{
			frames++;
			super.update();
			updateCollision();
			updateMovement();
			
			if (frames % shootOnFrame == 0) {
				shoot = true;
				shootOnFrame = MyGame.randRange(100, 130);
				frames = 0;
			}
			
			if (shoot) {
				MyGame.shotsAgainst++;
				world.add(new EnemyBullet(x + 1, y + 10, 28, 3, Colours.GRAPE));
				world.add(new EnemyBullet(x + 9, y + 10, 28, 3, Colours.GRAPE));
				shoot = false;
			}
		}
		
		private function updateCollision():void {
			if (collide("playerBullet", x, y)) {
				destroy();
			}
			if (collide("enemy", x, y)) {
					x += MyGame.randRange(-3, 3);
					y += MyGame.randRange(-2, 2);
			}
			
			if (collide("leftBorder", x, y)) {
				trace("collided with left: " + x);
				
				startX = x + 120;
				targetX = x + 20;
				
				x += dx/Math.abs(dx)*2;
			}
			if (collide("rightBorder", x, y)) {
				trace("collided with right: " + x);
				
				startX = x - 120;
				targetX = x - 20;
				
				x -= dx/Math.abs(dx)*2;
			}
			
			if (collide("bottomBorder", x, y)) {
				
				y -= dy/Math.abs(dy) * 2;
			}
			if (collide("topBorder", x, y)) {
				
				y += dy/Math.abs(dy) * 2;
			}
		}
		
		private function updateMovement():void {
			if (!hasStarted) {
				
				if(x != startX){
					startX = x;
					framesInOrigin = 0;
				}
				else
					framesInOrigin++;
					
				if (framesInOrigin > 12) {
					startX = x - 50;
					targetX = x + 50;
					hasStarted = true;
				}
			}
			else {
				
				if(goToStart){
					x += 20 * FP.elapsed;
					
					if (x >= targetX)
						goToStart = false;
				}
				else {
					x -= 20 * FP.elapsed;
					
					if (x <= startX)
						goToStart = true;
				}
				
			}
		}
	}
}