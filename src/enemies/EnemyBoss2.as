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
	public class EnemyBoss2 extends Entity 
	{
		private var dx:Number = 0.001;
		private var dy:Number = 0.001;
		
		private const hitSound:Sfx = new Sfx(Sounds.BOSS_HIT_3);
		
		[Embed(source="../../assets/enemies/boss2.png")] private const ENEMY_BOSS_GRAPHIC:Class;
		
		private var shoot:Boolean = false;
		private var frames:Number = 30;
		private var targetX:Number;
		private var startX:Number = -1;
		private var goToStart:Boolean = true;
		private var colour:uint;
		private var health:Number;
		private var hurt:Boolean = false;		
		private var framesHurt:Number = 0;
		private var oColour:uint;
		private var bossImage:Image;
		private var shootOnFrame:Number = 75;
		
		private var BITMAP_DATA:BitmapData;
		
		public function EnemyBoss2(posX:Number = 0, posY:Number = 0, myColour:uint = Colours.ORANGE_RED, startHealth:Number = 15) 
		{
			colour = myColour;
			health = startHealth;
						
			bossImage = new Image(ENEMY_BOSS_GRAPHIC);
			graphic = bossImage
			
			oColour = bossImage.color;
			
			super(x, y, graphic, mask);
			x = posX;
			y = posY;
			setHitboxTo(graphic);
			
			startX = x;
			targetX = x + 175;
			
			type = "enemyBoss";
			frames = 50;
		}
		
		public function destroy():void
        {
			MyGame.secondBoss = true;
			MyGame.score += 15;
			MyGame.lives++;
            graphic = null;
			if(MyGame.secondBoss)
				MyGame.enemyCount--;
			FP.world.remove(this);
        }
		
		override public function update():void 
		{
			frames++;
			super.update();
			updateCollision();
			updateMovement();
			
			if (frames % shootOnFrame == 0) {
				shootOnFrame = MyGame.randRange(60, 75);
				shoot = true;
			}
			
			if (shoot) {
				MyGame.shotsAgainst++;
				world.add(new EnemyBullet(x + 25, y + 46, 40, 5));
				shoot = false;
			}
			
		}
		
		private function updateCollision():void {
			if (collide("playerBullet", x, y)) {
				hitSound.play();
				health--;
				hurt = true;
			}
			if (health <= 0) {
				destroy();
			}
			
			if (hurt) {
				bossImage.color = colour;
				framesHurt++;
				if (framesHurt > 20) {
					bossImage.color = oColour;
					hurt = false;
					framesHurt = 0;
				}
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
				if(goToStart){
					x += 16 * FP.elapsed;
					
					if (x >= targetX)
						goToStart = false;
				}
				else {
					x -= 16 * FP.elapsed;
					
					if (x <= startX)
						goToStart = true;
				}		
		}
		
	}
}