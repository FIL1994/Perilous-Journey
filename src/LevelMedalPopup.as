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
	import com.newgrounds.components.MedalPopup;
	
	/**
	 * ...
	 * @author Philip VR
	 */
	public class LevelMedalPopup extends World
	{
		private var square:Entity
		public static var stage:Stage;
		
		public function LevelMedalPopup() 
		{
			stage = FP.stage;
			FP.screen.color = Colours.LIGHT_STEEL_BLUE;
			MyGame.currLevel = "LevelMedalPopup";
			MyGame.score = 0;
			
		}
		
		
		override public function begin():void 
		{
			
			var popup:MedalPopup = new MedalPopup();
			popup.scaleX = 0.9;
			popup.scaleY = 0.9;
			popup.x = FP.screen.width + 90;
			popup.y = 400;
			stage.addChild(popup);
			
			
			super.begin();
		}
		
		override public function update():void 
		{
			nextLevel();
			super.update();
		}
		
		private static function nextLevel():void {
			FP.world.removeAll();
			FP.world = new Level1();
		}
		
		override public function removeAll():void 
		{
			super.removeAll();
		}
	}

}