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
	public class EnemySide extends Entity 
	{
		private const death:Sfx = new Sfx(Sounds.ENEMY_DEATH_3);
		
		[Embed(source="../../assets/enemies/sideEnemy.png")] private const ENEMY_SQUARE_GRAPHIC:Class;
		
		private var dx:Number = 0.001;
		private var dy:Number = 0.001;
		
		private var shoot:Boolean = false;
		private var frames:Number = 30;
		private var shootOnFrame:Number = 85;
		private var targetY:Number;
		private var startY:Number = -1;
		private var framesInOrigin:Number = 0;
		private var hasStarted:Boolean = false;
		private var goToStart:Boolean = true;
		private var enemyImage:Image;
		
		public function EnemySide(x:Number = 0, y:Number = 0) 
		{
			enemyImage = new Image(ENEMY_SQUARE_GRAPHIC);
			graphic = enemyImage
			
			super(x, y, graphic, mask);
			this.x = x;
			this.y = y;
			setHitboxTo(graphic);
			
			type = "enemy";
			shootOnFrame = MyGame.randRange(80, 105);
			frames = MyGame.randRange(Number.floor(shootOnFrame - shootOnFrame / 1.5), shootOnFrame - 25);
		}
		
		public function destroy():void
        {
			death.play();
			MyGame.sideCanonsDefeated++;
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
			}
			
			if (shoot) {
				MyGame.shotsAgainst += 2;
				world.add(new EnemyBullet(x + 5, y + 6, 35, 3, Colours.YELLOW, true, false));
				world.add(new EnemyBullet(x + 5, y + 6, 35, 3, Colours.YELLOW, true, true));
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
				
				//startY = x + 120;
				//targetY = x + 20;
				
				x += dx/Math.abs(dx)*2;
			}
			if (collide("rightBorder", x, y)) {
				trace("collided with right: " + x);
				
				//startY = x - 120;
				//targetY = x - 20;
				
				x -= dx/Math.abs(dx)*2;
			}
			
			if (collide("bottomBorder", x, y)) {
				
				y -= dy/Math.abs(dy) * 2;
			}
			if (collide("topBorder", x, y)) {
				
				y += dy / Math.abs(dy) * 2;
				
				startY = y + 80;
				targetY = y + 103;
			}
		}
		
		private function updateMovement():void {
			if (!hasStarted) {
				
				if(y != startY){
					startY = y;
					framesInOrigin = 0;
				}
				else
					framesInOrigin++;
					
				if (framesInOrigin > 12) {
					startY = y - 23;
					targetY = y + 23;
					hasStarted = true;
				}
			}
			else {
				
				if(goToStart){
					y += 20 * FP.elapsed;
					
					if (y >= targetY)
						goToStart = false;
				}
				else {
					y -= 20 * FP.elapsed;
					
					if (y <= startY)
						goToStart = true;
				}
				
			}
		}
	}
}