package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Philip VR
	 */
	public class Player extends Entity
	{
		[Embed(source = "../assets/player.png")] private const PLAYER_GRAPHIC:Class;
		
		private const shoot:Sfx = new Sfx(Sounds.PLAYER_BULLET);
		private const death:Sfx = new Sfx(Sounds.PLAYER_DEATH);
		
		public var image:Image;
		private var dx:Number = 0.001;
		private var dy:Number = 0.001;
		private var moveSpeed:Number = 75;
		private var frames:Number = 0;
		private var framesSinceLastBullet:int = 0;
		
		public static var extraBullets:Boolean = false;
		public static var frameToStopExtraBullets:Number = 120;
		public static var bulletsStartFrame:Number = 0;
		
		private var laser:Boolean = false;
		private var gotHit:Boolean = false;
		private var gotHitFrames:Number = 0;
		
		private var oColour:uint;
		private var invincibleColour:uint = Colours.GRAPE;
		private var invincibleColour2:uint = Colours.SILVER;
		
		public function Player() 
		{
			image = new Image(PLAYER_GRAPHIC);
			graphic = image;
			setHitbox(16, 16, 0, 0);
			type = "player";
			
			oColour = image.color;
			
			//layer = 10;
			
			x = FP.screen.width / 2 - width;
			y = FP.screen.height - FP.screen.height / 5;
		}
		
		override public function update():void 
		{
			frames++;
			updateMovement();
			if(!gotHit)
				updateCollision();
			
			if (frames % 80 == 0) {	
				checkMedals();
			}
			
			if (extraBullets) {
				bulletsStartFrame++;
				if (bulletsStartFrame % frameToStopExtraBullets == 0)
					extraBullets = false;
			}
			
			if (gotHit) {
				gotHitFrames++;
				
				if(gotHitFrames % 55 > 12){
					image.color = invincibleColour;
				}
				else {
					image.color = invincibleColour2;
				}
				
				if (gotHitFrames > 110) {
					image.color = oColour;
					gotHitFrames = 0;
					gotHit = false;
				}
			}
			
			if (Input.pressed(Key.R) && (MyGame.currLevel != "LevelEndGame" || MyGame.currLevel != "LevelGameOver" 
				|| MyGame.currLevel != "LevelMedalPopup")) {
					
				FP.world.removeAll();
				FP.world = MyGame.thisLevel();					
			}
			
			if (MyGame.lives <= 0) {
				MyGame.totalScore += MyGame.score;
				FP.world.removeAll();
				NewgroundsConnect.postHighScore();
				MyGame.saveData();
				FP.world = new LevelGameOver();
			}
			
			
			super.update();
		}
		private function updateMovement():void {
			
			//Input.pressed --> getButtonDown
			//Input.check --> getButton
			if (Input.check(Key.RIGHT) || Input.check(Key.D)) {
					x += moveSpeed * FP.elapsed;
			}
			if (Input.check(Key.LEFT) || Input.check(Key.A)) {
					x -= moveSpeed * FP.elapsed;
			}
			if (Input.check(Key.UP) || Input.check(Key.W)) {
					y -= moveSpeed * FP.elapsed;
			}			
			if (Input.check(Key.DOWN)|| Input.check(Key.S)) {
					y += moveSpeed * FP.elapsed;
			}
			if (Input.check(Key.SPACE)) {
				if(framesSinceLastBullet % 9 == 0){
					shoot.play();
					world.add(new PlayerBullet(MyGame.generateBulletPath(3), x + 11, y));
					
					if(extraBullets){
						world.add(new PlayerBulletSimple(x + 11, y, 125, 3, true));
						world.add(new PlayerBulletSimple(x + 11, y, 125, 3, false));
					}
				}
				framesSinceLastBullet++;
			}
			else {
				framesSinceLastBullet = 9;
			}
			if (Input.pressed(Key.L)) {
				//laser = !laser;
			}
			
			//laser
			if(laser){
				if (Input.check(Key.SPACE)) {
					world.add(new PlayerBullet(MyGame.generateBulletPath(3), x + 10, y));
				}
			}
			
			if (Input.pressed(Key.M)) {
					MyGame.mute = !MyGame.mute;
					
					if(MyGame.mute)
						FP.volume = 0;
					else
						FP.volume = 1;
			}
		}
		
		private function updateCollision():void {
			
			if (collide("leftBorder", x, y)) {
				x += dx/Math.abs(dx)*2;
			}
			if (collide("rightBorder", x, y)) {
				x -= dx/Math.abs(dx)*2;
			}
			
			if (collide("bottomBorder", x, y)) {			
				y -= dy/Math.abs(dy) * 2;
			}
			if (collide("topBorder", x, y)) {	
				y += dy/Math.abs(dy) * 2;
			}
			
			
			if (collide("enemy", x, y) || collide("enemyBoss", x, y) || collide("enemyBullet", x, y)) {
				MyGame.lives--;
				trace("Lives: " + MyGame.lives);
				death.play();
				x = FP.screen.width / 2 - width;
				y = FP.screen.height - FP.screen.height / 5;
				gotHit = true;
			}
		}
		
		private function checkMedals():void {
			
			if (!MyGame.unlockedAegean10 && MyGame.aegeanDefeated >= 10) {
				NewgroundsConnect.unlockMedal("Aegean 10");
			}
			if (!MyGame.unlockedAegean50 && MyGame.aegeanDefeated >= 50)
					NewgroundsConnect.unlockMedal("Aegean 50");
					
			if (!MyGame.unlockedBronze10 && MyGame.bronzeDefeated >= 10) {
				NewgroundsConnect.unlockMedal("Bronze 10");
			}
			if (!MyGame.unlockedBronze50 && MyGame.bronzeDefeated >= 50)
					NewgroundsConnect.unlockMedal("Bronze 50");
			if (!MyGame.unlockedChartreuse10 && MyGame.chartreuseDefeated >= 10) {
				NewgroundsConnect.unlockMedal("Chartreuse 10");
			}
			if (!MyGame.unlockedChartreuse50 && MyGame.chartreuseDefeated >= 50)
					NewgroundsConnect.unlockMedal("Chartreuse 50");
			if (!MyGame.unlockedFuchsia10 && MyGame.fuchsiaDefeated >= 10) {
				NewgroundsConnect.unlockMedal("Fuchsia 10");
			}
			if (!MyGame.unlockedFuchsia50 && MyGame.fuchsiaDefeated >= 50)
					NewgroundsConnect.unlockMedal("Fuchsia 50");
			if (!MyGame.unlockedGreen10 && MyGame.greenDefeated >= 10) {
				NewgroundsConnect.unlockMedal("Green 10");
			}
			if (!MyGame.unlockedGreen50 && MyGame.greenDefeated >= 50)
					NewgroundsConnect.unlockMedal("Green 50");
			if (!MyGame.unlockedMahogany10 && MyGame.mahoganyDefeated >= 10) {
				NewgroundsConnect.unlockMedal("Mahogany 10");
			}
			if (!MyGame.unlockedMahogany50 && MyGame.mahoganyDefeated >= 50)
					NewgroundsConnect.unlockMedal("Mahogany 50");
			if (!MyGame.unlockedPecan10 && MyGame.pecanDefeated >= 10) {
				NewgroundsConnect.unlockMedal("Pecan 10");
			}
			if (!MyGame.unlockedPecan50 && MyGame.pecanDefeated >= 50)
					NewgroundsConnect.unlockMedal("Pecan 50");
			if (!MyGame.unlockedTeal10 && MyGame.tealDefeated >= 10) {
				NewgroundsConnect.unlockMedal("Teal 10");
			}
			if (!MyGame.unlockedTeal50 && MyGame.tealDefeated >= 50)
					NewgroundsConnect.unlockMedal("Teal 50");
			if (!MyGame.unlockedTiger10 && MyGame.tigerOrangeDefeated >= 10) {
				NewgroundsConnect.unlockMedal("Tiger Orange 10");
			}
			if (!MyGame.unlockedTiger50 && MyGame.tigerOrangeDefeated >= 50)
					NewgroundsConnect.unlockMedal("Tiger Orange 50");
			if (!MyGame.unlockedWatermelon10 && MyGame.watermelonDefeated >= 10) {
				NewgroundsConnect.unlockMedal("Watermelon 10");
			}
			if (!MyGame.unlockedWatermelon50 && MyGame.watermelonDefeated >= 50)
					NewgroundsConnect.unlockMedal("Watermelon 50");
			if (!MyGame.unlockedOrange10 && MyGame.orangeDefeated >= 10) {
				NewgroundsConnect.unlockMedal("Orange 10");
			}
			if (!MyGame.unlockedOrange50 && MyGame.orangeDefeated >= 50)
					NewgroundsConnect.unlockMedal("Orange 50");
			if (!MyGame.unlockedSquare10 && MyGame.squaresDefeated >= 10) {
				NewgroundsConnect.unlockMedal("Square 10");
			}
			if (!MyGame.unlockedSquare50 && MyGame.squaresDefeated >= 50)
					NewgroundsConnect.unlockMedal("Square 50");
			if (!MyGame.unlockedSideCanon10 && MyGame.sideCanonsDefeated >= 10) {
				NewgroundsConnect.unlockMedal("Side Canon 10");
			}
			if (!MyGame.unlockedSideCanon50 && MyGame.sideCanonsDefeated >= 50)
					NewgroundsConnect.unlockMedal("Side Canon 50");
					
			if (!MyGame.unlockedTwoShot10 && MyGame.twoShotsDefeated >= 10) {
				NewgroundsConnect.unlockMedal("Two Shot 10");
			}
			if (!MyGame.unlockedTwoShot50 && MyGame.twoShotsDefeated >= 50)
					NewgroundsConnect.unlockMedal("Two Shot 50");
			
			if (MyGame.totalScore > 3000) {
				NewgroundsConnect.unlockMedal("3000 Points");
				if (MyGame.totalScore > 3500) {
					NewgroundsConnect.unlockMedal("3500 Points");
					if (MyGame.totalScore > 4000) {
						NewgroundsConnect.unlockMedal("4000 Points");
					}
				}
			}
			
			if (!MyGame.unlockedLevel5 && MyGame.unlockLevel5) {
				NewgroundsConnect.unlockMedal("Level 5");
			}
			if (!MyGame.unlockedLevel8 && MyGame.unlockLevel8) {
				NewgroundsConnect.unlockMedal("Level 8");
			}
			
			if (MyGame.shotsAgainst >= 5000) {
				NewgroundsConnect.unlockMedal("5000 Enemy Bullets");
			}
		}
	}

}