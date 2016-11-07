package 
{
	import com.newgrounds.*;
	import com.newgrounds.components.MedalPopup;
	import com.newgrounds.components.FlashAd;
	import com.newgrounds.SaveGroup;
	//import com.newgrounds.SaveGroupQuery;
	
	import flash.display.*;
	import flash.utils.*;
	import net.flashpunk.FP;;
	/**
	 * ...
	 * @author Philip VR
	 */
	public class NewgroundsConnect 
	{
		public static var container:DisplayObjectContainer;
		
		public static var stageHeight:Number;
		
		public static var medalPopup:DisplayObject;
		public static var ad:DisplayObject;
		
		private static var medalNames:Array = [null, "testMedal1", "other medal"];
		
		
		public static function init (stage:Stage):void
		{
			trace("newgrounds started");
			//purposely left out
			var API_ID:String = "";
			var NG_KEY:String = "";
			
			API.connect(stage, API_ID, NG_KEY);
			stageHeight = stage.height;
			
		}
		
		public static function unlockMedal(medalName:String):void {
			//API.logCustomEvent("testing medal " + medalName);
			var unlockMedal1:Boolean = true;
			if (unlockMedal1) {
				var medal:Medal = API.getMedal(medalName);
					
					//if (! medal) continue;
					if(medal != null){
					if (!medal.unlocked) {
						medal.unlock();
						//showMedal(medal);
					}
					else if (medal.unlocked) {
						switch(medal.name) {
						case "Aegean 10":
							MyGame.unlockedAegean10 = true;
							break;
						case "Aegean 50":
							MyGame.unlockedAegean50 = true;
							break;
						case "Bronze 10":
							MyGame.unlockedBronze10 = true;
							break;
						case "Bronze 50":
							MyGame.unlockedBronze50;
							break;
						case "Chartreuse 10":
							MyGame.unlockedChartreuse10 = true;
							break;
						case "Chartreuse 50":
							MyGame.unlockedChartreuse50 = true;
							break;
						case "Fuchsia 10":
							MyGame.unlockedFuchsia10 = true;
							break;
						case "Fuchsia 50":
							MyGame.unlockedFuchsia50 = true;
							break;
						case "Green 10":
							MyGame.unlockedGreen10 = true;
							break;
						case "Green 50":
							MyGame.unlockedGreen50 = true;
							break;
						case "Mahogany 10":
							MyGame.unlockedMahogany10 = true;
							break;
						case "Mahogany 50":
							MyGame.unlockedMahogany50 = true;
							break;
						case "Orange 10":
							MyGame.unlockedOrange10 = true;
							break;
						case "Orange 50":
							MyGame.unlockedOrange50 = true;
							break;
						case "Pecan 10":
							MyGame.unlockedPecan10 = true;
							break;
						case "Pecan 50":
							MyGame.unlockedPecan50 = true;
							break;
						case "Teal 10":
							MyGame.unlockedTeal10 = true;
							break;
						case "Teal 50":
							MyGame.unlockedTeal50 = true;
							break;
						case "Tiger Orange 10":
							MyGame.unlockedTiger10 = true;
							break;
						case "Tiger Orange 50":
							MyGame.unlockedTiger50 = true;
							break;
						case "Watermelon 10":
							MyGame.unlockedWatermelon10 = true;
							break;
						case "Watermelon 50":
							MyGame.unlockedWatermelon50;
							break;
						case "Square 10":
							MyGame.unlockedSquare10 = true;
							break;
						case "Square 50":
							MyGame.unlockedSquare50 = true;
							break;
						case "Two Shot 10":
							MyGame.unlockedTwoShot10 = true;
							break;
						case "Two Shot 50":
							MyGame.unlockedTwoShot50 = true;
							break;
						case "Level 5":
							MyGame.unlockedLevel5 = true;
							break;
						case "Level 8":
							MyGame.unlockedLevel8 = true;
							break;
						default:
							break;
						}
					}
					}
			}
		}
		
		public static function checkMedal(medalName:String):Boolean {
			return API.getMedal(medalName).unlocked;
		}
		
		public static function createAd():DisplayObject {
			//if (! API.connected) return null;
			
			return new FlashAd();
		}
		
		public static function postHighScore():void {
			trace("posting score of :" + MyGame.totalScore);
			API.postScore("High Score", MyGame.totalScore);
		}
		
		public static function update():void {
			if (! API.connected) return;
			if (API.isNewgrounds) return;
			//Preloader.mustClick = true;
		}
		
		public static function isSignedIn():Boolean {
			return API.hasUserSession;
		}
		
		public static function getUsername():String {
			return API.username;
		}
		
		public static function N_API_Output(string:String):void {
			API.logCustomEvent(string);
		}
		
		public static function saveFile(varName:String, object:String):void {	
			API.logCustomEvent("saving file " + varName + ": " + API.saveLocal(varName, object));
		}
		
		public static function loadFile(varName:String):String {
			//will crash if tries to load file that does not exist
			try{
				var var_value:Object = API.loadLocal(varName);
				if (varName is Class(getDefinitionByName(getQualifiedClassName(var_value)))) {
					//break;
					var value:String = new String(var_value);
					API.logCustomEvent(varName + " - " + value);
					return value;
				}
				else {
					API.logCustomEvent("failed: " + String(value.toString()) + Class(getDefinitionByName(getQualifiedClassName(var_value))));
					return "failed";
				}
			}
			catch (ex:Error) {
				API.logCustomEvent("Load Failed: " + ex.message);
				return "failed";
			}
			return "failed";
		}
		
	}

}