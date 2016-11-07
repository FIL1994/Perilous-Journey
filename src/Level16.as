package 
{
	import enemies.Enemy;
	import enemies.EnemySide;
	import enemies.EnemySquare;
	import enemies.EnemyTwoShots;
	
	import flash.utils.getTimer;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import ScreenBorders.BottomBorder;
	import ScreenBorders.LeftBorder;
	import ScreenBorders.RightBorder;
	import com.newgrounds.components.MedalPopup;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import ScreenBorders.TopBorder;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Philip VR
	 */
	public class Level16 extends World
	{
		private var square:Entity
		public static var stage:Stage;
		private var levelText:TextField = new TextField();
		private var myFormat:TextFormat = new TextFormat();
		private var scoreText:TextField = new TextField();
		private var livesText:TextField = new TextField();
		private var levelSeconds:int = getTimer() * 0.001;
		private var beatTime:int = 18;
		
		public function Level16() 
		{
			stage = FP.stage;
			FP.screen.color = Colours.LIGHT_STEEL_BLUE;
			MyGame.currLevel = "Level16";
			MyGame.score = 0;
		}
		
		
		override public function begin():void 
		{			
			add(new Player);
			add(new LeftBorder);
			add(new RightBorder);
			add(new BottomBorder);
			add(new TopBorder);
			
			add(new EnemySide(50, 50));
			add(new EnemySide(75, 50));
			add(new EnemySide(255, 50));
			add(new EnemySide(230, 50));
			
			add(new EnemyTwoShots(70, 50));
			add(new EnemyTwoShots(200, 50));
			add(new EnemyTwoShots(70, 30));
			add(new EnemyTwoShots(200, 30));
			
			add(new EnemyTwoShots(90, 50));
			add(new EnemyTwoShots(135, 50));
			add(new EnemyTwoShots(90, 30));
			add(new EnemyTwoShots(135, 30));
			add(new EnemyTwoShots(180, 30));
			add(new EnemyTwoShots(180, 50));
			
			add(new Enemy(140, 40, MyGame.randomEnemyColour(), true));
			add(new Enemy(110, 40, MyGame.randomEnemyColour(), true));
			add(new Enemy(150, 60, MyGame.randomEnemyColour(), true));
			add(new Enemy(120, 60, MyGame.randomEnemyColour(), true));
			
			add(new Enemy(210, 40, MyGame.randomEnemyColour(), true));
			add(new Enemy(70, 40, MyGame.randomEnemyColour(), true));
			add(new Enemy(210, 60, MyGame.randomEnemyColour(), true));
			add(new Enemy(70, 60, MyGame.randomEnemyColour(), true));
			
			MyGame.enemyCount = 22;			
			
			levelText.defaultTextFormat = new TextFormat("Iceland", 22);
			levelText.embedFonts = true;
			levelText.textColor = Colours.CRIMSON;
			levelText.text = "Level 16";					
			levelText.x = 8;
			levelText.y = FP.screen.height + 175;
			
			scoreText.defaultTextFormat = new TextFormat("Iceland", 22);
			scoreText.defaultTextFormat.align = TextFormatAlign.CENTER;
			scoreText.autoSize = TextFieldAutoSize.CENTER;
			scoreText.embedFonts = true;
			scoreText.textColor = Colours.CRIMSON;
			scoreText.text = "Score: " + MyGame.score;
			scoreText.y = FP.screen.height + 160;
			scoreText.x = FP.screen.width + 215;
			
			livesText.defaultTextFormat = new TextFormat("Iceland", 22);
			livesText.embedFonts = true;
			livesText.textColor = Colours.CRIMSON;
			livesText.text = "Lives: " + MyGame.lives;
			livesText.y = FP.screen.height + 185;
			livesText.x = FP.screen.width + 218;
			
			FP.stage.addChild(levelText);
			FP.stage.addChild(scoreText);
			FP.stage.addChild(livesText);
			
			super.begin();
		}
		
		override public function update():void 
		{
			if (MyGame.enemyCount == 0) {
				nextLevel();
			}
			levelText.text = "Level 16";
			scoreText.text = "Score: " + (MyGame.score + MyGame.totalScore);
			scoreText.x = FP.screen.width + 222 - (scoreText.text.length - 7) * 8;
			livesText.text = "Lives: " + MyGame.lives;
			super.update();
		}
		
		private function nextLevel():void {	
			MyGame.unlockLevel8 = true;
			
			MyGame.totalScore += MyGame.score;
			
			var bonus:int = beatTime - levelSeconds
			if (bonus > 0)
				MyGame.totalScore += bonus * 13;
				
			MyGame.saveData();
			
			levelSeconds = (getTimer() * 0.001) - levelSeconds;
			trace("16-Seconds: " + levelSeconds);
			FP.world.removeAll();
			levelText.visible = false;
			FP.world = new Level17();
		}
		
		override public function removeAll():void 
		{
			FP.stage.removeChild(levelText);
			FP.stage.removeChild(scoreText);
			FP.stage.removeChild(livesText);
			super.removeAll();
		}
	}

}