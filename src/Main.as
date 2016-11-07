package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import flash.ui.Mouse;
	import flash.display.*;
	import enemies.EnemySquare;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Philip VR
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Engine
	{
		private const theme:Sfx = new Sfx(Sounds.PERILOUS_JOURNEY_THEME);
		private const startGameSound:Sfx = new Sfx(Sounds.START_GAME);
		private const gameOverSound:Sfx = new Sfx(Sounds.GAME_OVER);
		private var starting:Boolean = true;
		private var playedGameOver:Boolean = false;
		private var frames:int = 20;
		
		public function Main() 
		{
			super(320, 240, 45, true);
			FP.screen.scale = 2;
			//FP.console.enable();
			FP.screen.color = Colours.LIGHT_STEEL_BLUE;	
			
			//NewgroundsConnect.N_API_Output("Signed in: " + NewgroundsConnect.isSignedIn());
			//if(NewgroundsConnect.isSignedIn()){
				//NewgroundsConnect.N_API_Output("Username: " + NewgroundsConnect.getUsername());
			//}
			
			startGameSound.play();
			
			//if (stage) init();
			//else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		override public function init():void
		{
			if (NewgroundsConnect.isSignedIn())
				FP.world = new LevelMedalPopup();
			else
				FP.world = new Level1();
			
			super.init();
			
			loadSaveData();
		}
		
		override public function update():void 
		{
			
			frames++;
			if (startGameSound.position >= startGameSound.length - 0.2) {
				if (starting == true){
					theme.loop();
					starting = false;
				}
			}
			
			if(playedGameOver){
				if ((gameOverSound.position == 0 && MyGame.currLevel != "LevelGameOver")) {
					playedGameOver = false;
				}
				else {
					playedGameOver = true;
				}
			}
			
			if (!playedGameOver && MyGame.lives <= 0 && gameOverSound.position == 0) {
				gameOverSound.play();
				playedGameOver = true;
			}
			
			super.update();
						
			if (frames % 60 == 0) {	
				checkMedals();
			}
		}
		
		private function checkMedals():void {
			MyGame.testScores();
			
			if (MyGame.firstBoss)
				NewgroundsConnect.unlockMedal("First Boss Defeated");
			if (MyGame.secondBoss)
				NewgroundsConnect.unlockMedal("Second Boss Defeated");
			if (MyGame.thirdBoss)
				NewgroundsConnect.unlockMedal("Third Boss Defeated");
			if (MyGame.fourthBoss)
				NewgroundsConnect.unlockMedal("Fourth Boss Defeated");
			if (MyGame.fifthBoss)
				NewgroundsConnect.unlockMedal("Fifth Boss Defeated");
			if (MyGame.sixthBoss)
				NewgroundsConnect.unlockMedal("Sixth Boss Defeated");
			if (MyGame.seventhBoss)
				NewgroundsConnect.unlockMedal("Seventh Boss Defeated");
			if (MyGame.eighthBoss)
				NewgroundsConnect.unlockMedal("Eighth Boss Defeated");
			if (MyGame.ninthBoss){
				NewgroundsConnect.unlockMedal("Ninth Boss Defeated");
				NewgroundsConnect.unlockMedal("Winner!");
			}
			if (MyGame.points3000)
				NewgroundsConnect.unlockMedal("3000 Points");
			if (MyGame.points3500)
				NewgroundsConnect.unlockMedal("3500 Points");
			if (MyGame.points4000)
				NewgroundsConnect.unlockMedal("4000 Points");
				
		}
		
		private function loadSaveData():void {
			
			var loadValue:String = NewgroundsConnect.loadFile("aegean");
			if(loadValue != null && loadValue != "failed")
				MyGame.aegeanDefeated = Number(loadValue);
				
			loadValue = NewgroundsConnect.loadFile("bronze");
			if(loadValue != null && loadValue != "failed")
				MyGame.bronzeDefeated = Number(loadValue);	
			
			loadValue = NewgroundsConnect.loadFile("pecan");
			if(loadValue != null && loadValue != "failed")
				MyGame.pecanDefeated = Number(loadValue);
				
			loadValue = NewgroundsConnect.loadFile("tiger");
			if(loadValue != null && loadValue != "failed")
				MyGame.tigerOrangeDefeated = Number(loadValue);	
				
			loadValue = NewgroundsConnect.loadFile("fuchsia");
			if(loadValue != null && loadValue != "failed")
				MyGame.fuchsiaDefeated = Number(loadValue);	
				
			loadValue = NewgroundsConnect.loadFile("chartreuse");
			if(loadValue != null && loadValue != "failed")
				MyGame.chartreuseDefeated = Number(loadValue);	
				
			loadValue = NewgroundsConnect.loadFile("mahogany");
			if(loadValue != null && loadValue != "failed")
				MyGame.mahoganyDefeated = Number(loadValue);	
				
			loadValue = NewgroundsConnect.loadFile("green");
			if(loadValue != null && loadValue != "failed")
				MyGame.greenDefeated = Number(loadValue);	
				
			loadValue = NewgroundsConnect.loadFile("watermelon");
			if(loadValue != null && loadValue != "failed")
				MyGame.watermelonDefeated = Number(loadValue);	
				
			loadValue = NewgroundsConnect.loadFile("teal");
			if(loadValue != null && loadValue != "failed")
				MyGame.tealDefeated = Number(loadValue);	
	
			loadValue = NewgroundsConnect.loadFile("orange");
			if(loadValue != null && loadValue != "failed")
				MyGame.orangeDefeated = Number(loadValue);
				
			loadValue = NewgroundsConnect.loadFile("square");
			if(loadValue != null && loadValue != "failed")
				MyGame.squaresDefeated = Number(loadValue);
				
			loadValue = NewgroundsConnect.loadFile("twoShots");
			if(loadValue != null && loadValue != "failed")
				MyGame.twoShotsDefeated = Number(loadValue);
				
			loadValue = NewgroundsConnect.loadFile("shotsAgainst");
			if(loadValue != null && loadValue != "failed")
				MyGame.shotsAgainst = Number(loadValue);
		}

	}

}