package 
{
	import enemies.Enemy;
	import enemies.EnemyBoss;
	
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
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.Tween;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	
	/**
	 * ...
	 * @author Philip VR
	 */
	public class LevelGameOver extends World
	{
		private var square:Entity
		public static var stage:Stage;
		
		private var myFormat:TextFormat = new TextFormat();
		
		private var totalScoreText:TextField = new TextField();
		private var scoreText:TextField = new TextField();
		private var scorePosted:TextField = new TextField();
		private var myFunction:Function = function():void { nextLevel(); };
		private var playAgain:PushButton = new PushButton(null, 250, 210, "Try Again", myFunction);
		private var framesSinceTween:int = 0;
		private var dotPosition:int = 0;
		
		private var scoreAt:Number = 0;
		
		private var skip:Boolean = false;
		
		private var tweener:NumTween;
		
		private var postedScoreX:int = 0;
		
		public function LevelGameOver() 
		{
			stage = FP.stage;
			FP.screen.color = Colours.SHADOW;
			MyGame.currLevel = "LevelGameOver";
			MyGame.score = 0;
		}
		
		
		override public function begin():void 
		{
			
			if (MyGame.totalScore > 3000) {
				NewgroundsConnect.unlockMedal("3000 Points");
				if (MyGame.totalScore > 3500) {
					NewgroundsConnect.unlockMedal("3500 Points");
					if (MyGame.totalScore > 4000) {
						NewgroundsConnect.unlockMedal("4000 Points");
					}
				}
			}
			
			playAgain.setSize(135, 45);
			//Style.setStyle(Style.DARK);
			playAgain.visible = false;
			
			add(new LeftBorder);
			add(new RightBorder);
			add(new BottomBorder);
			add(new TopBorder);
			
			FP.stage.addChild(playAgain);
			
			scoreText.defaultTextFormat = new TextFormat("Iceland", 35);
			scoreText.defaultTextFormat.align = TextFormatAlign.CENTER;
			scoreText.embedFonts = true;
			scoreText.textColor = Colours.CRIMSON;
			scoreText.text = "Total Score";
			scoreText.y = FP.stage.height / 3 - 50;
			scoreText.x = (FP.stage.width / 2) - scoreText.textWidth/3;
			scoreText.autoSize = TextFieldAutoSize.CENTER;
			
			totalScoreText.defaultTextFormat = new TextFormat("Iceland", 30);
			totalScoreText.defaultTextFormat.align = TextFormatAlign.CENTER;
			totalScoreText.embedFonts = true;
			totalScoreText.textColor = Colours.CRIMSON;
			totalScoreText.text = "" + scoreAt;
			totalScoreText.y = (FP.stage.height / 3);
			totalScoreText.x = (FP.stage.width / 2) - scoreText.textWidth/3;
			totalScoreText.autoSize = TextFieldAutoSize.CENTER;
			
			scorePosted.defaultTextFormat = new TextFormat("Iceland", 20);
			scorePosted.defaultTextFormat.align = TextFormatAlign.CENTER;
			scorePosted.embedFonts = true;
			scorePosted.textColor = Colours.CRIMSON;
			scorePosted.text = "Posting your score .";
			scorePosted.y = 270;
			scorePosted.x = (FP.stage.width / 2) - scoreText.textWidth/3;
			scorePosted.autoSize = TextFieldAutoSize.CENTER;
			
			FP.stage.addChild(totalScoreText);
			FP.stage.addChild(scoreText);
			FP.stage.addChild(scorePosted);
			
			tweener = new NumTween();
			
			tweener.tween(0, MyGame.totalScore, 190);
			
			tweener.start();
			
			scorePosted.visible = false;
			
			super.begin();
		}
		
		override public function update():void 
		{
			if(3> postedScoreX){
				MyGame.endGame();
				 postedScoreX++;
			}
			playAgain.visible = true;
			/*
			if(tweener.value < MyGame.totalScore)
				tweener.update();
			else{
				playAgain.visible = true;
				scorePosted.visible = true;
				
				framesSinceTween++;
				
				if (framesSinceTween > 180){
					scorePosted.text = "Your score has been posted";
				}
				else{
					if (framesSinceTween % 24 == 0) {
						if (dotPosition > 3) dotPosition = 0;
						switch(dotPosition) {
							case 0:
								scorePosted.replaceText(19, scorePosted.length, ".");
								break;
							case 1:
								scorePosted.replaceText(19, scorePosted.length, "..");
								break;
							case 2:
								scorePosted.replaceText(19, scorePosted.length, "...");
								break;
							case 3:
								scorePosted.replaceText(19, scorePosted.length, "....");
								break;
						}
						dotPosition++;
					}
				}			
			}
			*/	
			//totalScoreText.text = "" + Number.round(tweener.value);
			totalScoreText.text = "" + MyGame.totalScore;
			super.update();
		}
		
		private static function nextLevel():void {
			MyGame.lives = 5;
			FP.world.removeAll();
			FP.world = new Level1();
		}
		
		override public function removeAll():void 
		{
			FP.stage.removeChild(totalScoreText);
			FP.stage.removeChild(scoreText);
			FP.stage.removeChild(scorePosted);
			FP.stage.removeChild(playAgain);
			super.removeAll();
		}
	}

}