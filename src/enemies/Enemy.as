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
	public class Enemy extends Entity 
	{
		private const death:Sfx = new Sfx(Sounds.ENEMY_DEATH);
		
		private var dx:Number = 0.001;
		private var dy:Number = 0.001;
		
		private var canShoot:Boolean = false;
		private var shoot:Boolean = false;
		private var frames:Number = 30;
		private var shootOnFrame:Number = 85;
		private var targetX:Number;
		private var startX:Number = -1;
		private var framesInOrigin:Number = 0;
		private var hasStarted:Boolean = false;
		private var goToStart:Boolean = true;
		private var colour:uint;
		
		private var BITMAP_DATA:BitmapData;
		
		public function Enemy(x:Number = 0, y:Number = 0, colour:uint = Colours.ORANGE_RED, canShoot:Boolean = false) 
		{
			this.colour = colour;
			BITMAP_DATA = new BitmapData(12, 12, true, colour);
			makeBitmap();
			this.canShoot = canShoot;
			
			
			var image:Image = new Image(BITMAP_DATA);
			graphic = image
			super(x, y, graphic, mask);
			this.x = x;
			this.y = y;
			setHitboxTo(graphic);
			
			type = "enemy";
			shootOnFrame = MyGame.randRange(125, 185);
			frames = MyGame.randRange(Number.floor(shootOnFrame - shootOnFrame / 1.5), shootOnFrame - 25);
		}
		
		public function destroy():void
        {
			death.play();
            MyGame.score += 1;
            graphic = null;
			if(MyGame.enemyCount > 0){
				MyGame.enemyCount--;
			}
			increaseDefeated();
			trace("Enemy count: " + MyGame.enemyCount);
			FP.world.remove(this);
        }
		
		override public function update():void 
		{
			frames++;
			super.update();
			updateCollision();
			updateMovement();
			
			if(canShoot){
				if (frames % shootOnFrame == 0) {
					shoot = true;
				}
				
				if (shoot) {
					MyGame.shotsAgainst++;
					world.add(new EnemyBullet(x + 5, y + 6, 20, 3));
					shoot = false;
				}
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
					startX = x - 60;
					targetX = x + 60;
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
		
		private function increaseDefeated():void {
			switch(colour.toString()) {
				case Colours.AEGEAN.toString():
					MyGame.aegeanDefeated++;
					trace("Aegan: " + MyGame.aegeanDefeated);
					break;
				case Colours.BRONZE.toString():
					MyGame.bronzeDefeated++;
					trace("Bronze: " + MyGame.bronzeDefeated);
					break;
				case Colours.PECAN.toString():
					MyGame.pecanDefeated++;
					trace("Pecan: " + MyGame.pecanDefeated);
					break;
				case Colours.TIGER_ORANGE.toString():
					MyGame.tigerOrangeDefeated++;
					trace("Tiger orange: " + MyGame.tigerOrangeDefeated);
					break;
				case Colours.FUCHSIA.toString():
					MyGame.fuchsiaDefeated++;
					trace("Fuchsia: " + MyGame.fuchsiaDefeated);
					break;
				case Colours.CHARTREUSE.toString():
					MyGame.chartreuseDefeated++;
					trace("Chartreuse: " + MyGame.chartreuseDefeated);
					break;
				case Colours.MAHOGANY.toString():
					MyGame.mahoganyDefeated++;
					trace("Mahogany: " + MyGame.mahoganyDefeated); 
					break;
				case Colours.GREEN.toString():
					MyGame.greenDefeated++;
					trace("Green: " + MyGame.greenDefeated);
					break;
				case Colours.WATERMELON.toString():
					MyGame.watermelonDefeated++;
					trace("Watermelon: " + MyGame.watermelonDefeated);
					break;
				case Colours.TEAL.toString():
					MyGame.tealDefeated++;
					trace("Teal: " + MyGame.tealDefeated);
					break;
				case Colours.DARK_ORANGE.toString():					
					MyGame.orangeDefeated++;
					trace("Orange: " + MyGame.orangeDefeated);
					break;
				default:
					trace("Colour did not match");
					break;
			}
		}
		
		private function makeBitmap():void {
			var xPixel:Number = 0;
			var yPixel:Number = 0;
			
			for (var i:int = 0; i < 12; i++) 
			{
				if (xPixel <= 1 || xPixel >= 10) {
					BITMAP_DATA.setPixel32(xPixel, yPixel, 0x00FFFFFF);
				}
				else
					BITMAP_DATA.setPixel32(xPixel, yPixel, colour);
				xPixel++;
			}
			
			yPixel++;
			xPixel = 0;
			for (var i2:int = 0; i2 < 12; i2++) 
			{
				if (xPixel == 0 || xPixel == 11) {
					BITMAP_DATA.setPixel32(xPixel, yPixel, 0x00FFFFFF);
				}
				else
					BITMAP_DATA.setPixel32(xPixel, yPixel, colour);
				xPixel++;
			}
			
			yPixel = 4;
			xPixel = 0;
			for (var i3:int = 0; i3 < 12; i3++) 
			{
				if (xPixel <= 2 || xPixel >= 9) {
					BITMAP_DATA.setPixel32(xPixel, yPixel, 0x00FFFFFF);
				}
				else
					BITMAP_DATA.setPixel32(xPixel, yPixel, colour);
				xPixel++;
			}
			
			yPixel = 6;
			xPixel = 0;
			for (var i4:int = 0; i4 < 12; i4++) 
			{
				if (xPixel <= 2 || xPixel >= 9) {
					BITMAP_DATA.setPixel32(xPixel, yPixel, 0x00FFFFFF);
				}
				else
					BITMAP_DATA.setPixel32(xPixel, yPixel, colour);
				xPixel++;
			}
			
			yPixel = 9;
			xPixel = 0;
			for (var i5:int = 0; i5 < 12; i5++) 
			{
				if (xPixel == 0 || xPixel == 11) {
					BITMAP_DATA.setPixel32(xPixel, yPixel, 0x00FFFFFF);
				}
				else
					BITMAP_DATA.setPixel32(xPixel, yPixel, colour);
				xPixel++;
			}
			
			yPixel = 10;
			xPixel = 0;
			for (var i6:int = 0; i6 < 12; i6++) 
			{
				if (xPixel <= 2 || xPixel >= 9) {
					BITMAP_DATA.setPixel32(xPixel, yPixel, 0x00FFFFFF);
				}
				else
					BITMAP_DATA.setPixel32(xPixel, yPixel, colour);
				xPixel++;
			}
			
			yPixel = 11;
			xPixel = 0;
			for (var i7:int = 0; i7 < 12; i7++) 
			{
				if (xPixel <= 3 || xPixel >= 8) {
					BITMAP_DATA.setPixel32(xPixel, yPixel, 0x00FFFFFF);
				}
				else
					BITMAP_DATA.setPixel32(xPixel, yPixel, colour);
				xPixel++;
			}
		}
		
	}
}