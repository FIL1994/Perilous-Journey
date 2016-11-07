package
{
	import enemies.Enemy;
	import enemies.EnemySquare;
	
	import flash.utils.getTimer;
	import flash.display.BitmapData;
	import flash.net.FileReferenceList;
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
	import MyGame;
	import ScreenBorders.TopBorder;
	import net.flashpunk.FP;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	
	/**
	 * ...
	 * @author Philip VR
	 */
	public class Level1 extends World
	{
		private var square:Entity
		public static var stage:Stage;
		private var levelText:TextField = new TextField();
		private var scoreText:TextField = new TextField();
		private var livesText:TextField = new TextField();
		private var levelSeconds:int = getTimer() * 0.001;
		private var beatTime:int = 12;
		
		public function Level1() 
		{
			stage = FP.stage;
			FP.screen.color = Colours.LIGHT_STEEL_BLUE;
			MyGame.totalScore = 0;
		}
		
		
		override public function begin():void 
		{
			var image:Image = new Image(new BitmapData(16, 16, true, 0xffffffff));
			square = new Entity(0, 0, image);
			//add(square);
			
			add(new Player);
			add(new LeftBorder);
			add(new RightBorder);
			add(new BottomBorder);
			add(new TopBorder);
			
			add(new Enemy(FP.screen.width / 2, 30, MyGame.randomEnemyColour()));
			add(new Enemy(FP.screen.width / 3, 30, MyGame.randomEnemyColour()));
			add(new Enemy(FP.screen.width / 2, 30, MyGame.randomEnemyColour()));
			add(new Enemy(FP.screen.width / 2, 30, MyGame.randomEnemyColour()));
			add(new Enemy(FP.screen.width / 3, 50, MyGame.randomEnemyColour()));
			add(new Enemy(FP.screen.width / 3, 50, MyGame.randomEnemyColour()));
			add(new Enemy(FP.screen.width / 2, 50, MyGame.randomEnemyColour()));
			add(new Enemy(FP.screen.width / 3, 50, MyGame.randomEnemyColour()));
			
			MyGame.enemyCount = 8;
			
			MyGame.score = 0;
			MyGame.currLevel = "Level1";
			
			levelText.defaultTextFormat = new TextFormat("Iceland", 22);
			levelText.embedFonts = true;
			levelText.textColor = Colours.CRIMSON;
			levelText.text = "Level 1";
			levelText.x = 8;
			levelText.y = FP.screen.height + 175;
			
			scoreText.defaultTextFormat = new TextFormat("Iceland", 22);
			scoreText.defaultTextFormat.align = TextFormatAlign.CENTER;
			scoreText.autoSize = TextFieldAutoSize.CENTER;
			scoreText.embedFonts = true;
			scoreText.textColor = Colours.CRIMSON;
			scoreText.text = "Score: " + MyGame.score;
			scoreText.y = FP.screen.height + 160;
			scoreText.x = FP.screen.width + 222 - scoreText.text.length;
			
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
			levelText.text = "Level 1";
			scoreText.text = "Score: " + (MyGame.score + MyGame.totalScore);
			scoreText.x = FP.screen.width + 222 - (scoreText.text.length - 7) * 8;
			livesText.text = "Lives: " + MyGame.lives;
			super.update();
		}
		
		private function nextLevel():void {
			levelSeconds = (getTimer() * 0.001) - levelSeconds;
			trace("1-Seconds: " + levelSeconds);
			
			MyGame.totalScore += MyGame.score;
			
			var bonus:int = beatTime - levelSeconds
			if (bonus > 0)
				MyGame.totalScore += bonus * 6;
			
			MyGame.saveData();
				
			FP.world.removeAll();
			levelText.visible = false;
			FP.world = new Level2();
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