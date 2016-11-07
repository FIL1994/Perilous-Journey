package 
{
	import net.flashpunk.World;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Philip VR
	 */
	public class MyGame 
	{
		public static var elapsedSeconds:int = getTimer() * 0.001;
		public static var mute:Boolean = false;

		public static var currLevel:String = "Level1";
		public static var enemyCount:Number;
		public static var bossCount:Number;
		public static var lives:Number = 5;
		
		public static var score:Number = 0;
		public static var totalScore:Number = 0;
		
		public static var firstBoss:Boolean = false;
		public static var secondBoss:Boolean = false;
		public static var thirdBoss:Boolean = false;
		public static var fourthBoss:Boolean = false;
		public static var fifthBoss:Boolean = false;
		public static var sixthBoss:Boolean = false;
		public static var seventhBoss:Boolean = false;
		public static var eighthBoss:Boolean =  false;
		public static var ninthBoss:Boolean =  false;
		
		public static var points3000:Boolean = false;
		public static var points3500:Boolean = false;
		public static var points4000:Boolean = false;
		
		public static var aegeanDefeated:Number = 0;
		public static var bronzeDefeated:Number = 0;
		public static var pecanDefeated:Number = 0;
		public static var tigerOrangeDefeated:Number = 0;
		public static var fuchsiaDefeated:Number = 0;
		public static var chartreuseDefeated:Number = 0;
		public static var mahoganyDefeated:Number = 0;
		public static var greenDefeated:Number = 0;
		public static var watermelonDefeated:Number = 0;
		public static var tealDefeated:Number = 0;
		public static var orangeDefeated:Number = 0;
		
		public static var squaresDefeated:Number = 0;
		public static var sideCanonsDefeated:Number = 0;
		public static var twoShotsDefeated:Number = 0;
		
		public static var shotsAgainst:Number = 0;
		
		public static var unlockLevel5:Boolean = false;
		public static var unlockedLevel5:Boolean = false;
		public static var unlockLevel8:Boolean = false;
		public static var unlockedLevel8:Boolean = false;
		
		public static var unlockedAegean10:Boolean = false;
		public static var unlockedAegean50:Boolean = false;
		public static var unlockedBronze10:Boolean = false;
		public static var unlockedBronze50:Boolean = false;
		public static var unlockedPecan10:Boolean = false;
		public static var unlockedPecan50:Boolean = false;
		public static var unlockedTiger10:Boolean = false;
		public static var unlockedTiger50:Boolean = false;
		public static var unlockedFuchsia10:Boolean = false;
		public static var unlockedFuchsia50:Boolean = false;
		public static var unlockedChartreuse10:Boolean = false;
		public static var unlockedChartreuse50:Boolean = false;
		public static var unlockedMahogany10:Boolean = false;
		public static var unlockedMahogany50:Boolean = false;
		public static var unlockedGreen10:Boolean = false;
		public static var unlockedGreen50:Boolean = false;
		public static var unlockedWatermelon10:Boolean = false;
		public static var unlockedWatermelon50:Boolean = false;
		public static var unlockedTeal10:Boolean = false;
		public static var unlockedTeal50:Boolean = false;
		public static var unlockedOrange10:Boolean = false;
		public static var unlockedOrange50:Boolean = false;
		
		public static var unlockedSquare10:Boolean = false;
		public static var unlockedSquare50:Boolean = false;
		
		public static var unlockedTwoShot10:Boolean = false;
		public static var unlockedTwoShot50:Boolean = false;
		
		public static var unlockedSideCanon10:Boolean = false;
		public static var unlockedSideCanon50:Boolean = false;
		
		[Embed(source = "../fonts/Iceland-Regular.ttf",
		fontName = "Iceland",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF="false")]
		public static var icelandFont:Class;
		
		public function MyGame() 
		{
			
		}
		
		public static function thisLevel():World {
			switch(currLevel) {
				case "Level1":
					return new Level1();
				case "Level2":
					return new Level2();
				case "Level3":
					return new Level3();
				case "Level4":
					return new Level4();
				case "Level5":
					return new Level5();
				case "Level6":
					return new Level6();
				case "Level7":
					return new Level7();
				case "Level8":
					return new Level8();
				case "Level9":
					return new Level9();
				case "Level10":
					return new Level10();
				case "Level11":
					return new Level11();
				case "Level12":
					return new Level12();
				case "Level13":
					return new Level13();
				case "Level14":
					return new Level14();
				case "Level15":
					return new Level15();
				case "Level16":
					return new Level16();
				case "Level17":
					return new Level17();
				case "Level18":
					return new Level18();
				case "Level19":
					return new Level19();
				case "Level20":
					return new Level20();
				case "Level21":
					return new Level21();
				case "Level22":
					return new Level22();
				case "Level23":
					return new Level23();
				case "Level24":
					return new Level24();
				case "Level25":
					return new Level25();
				default:
					return new Level1();
			}
		}
		
		public static function generateBulletPath(distanceBetweenPoints:Number):Vector.<Point>
		{
			var i:Number;
			 
			var vec:Vector.<Point> = new Vector.<Point>();
			 
				for (i = 0; i > -500; i -= distanceBetweenPoints)
				{
					vec.push(new Point(0, i));
				}			
			 
			return vec;
		}
		
		public static function randRange(min:Number, max:Number):Number {
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}
		
		public static function randomEnemyColour():uint {
			//var randNum:Number = randRange(1, 6);
			switch(randRange(1, 11)){
				case 1:
					return Colours.AEGEAN;
				case 2:
					return Colours.BRONZE;
				case 3:
					return Colours.PECAN;
				case 4:
					return Colours.TIGER_ORANGE;
				case 5:
					return Colours.FUCHSIA;
				case 6:
					return Colours.CHARTREUSE;
				case 7:
					return Colours.MAHOGANY;
				case 8:
					return Colours.GREEN;
				case 9:
					return Colours.WATERMELON;
				case 10:
					return Colours.TEAL;
				default:
					return Colours.DARK_ORANGE;
			}
		}
		
		public static function randomColour():uint {
			switch(randRange(1, 15)) {
				case 1:
					return Colours.SANGRIA;
				case 2:
					return Colours.TURQUOISE;
				case 3:
					return Colours.TEAL;
				case 4:
					return Colours.SILVER;
				case 5:
					return Colours.WATERMELON;
				case 6:
					return Colours.TOMATO;
				case 7:
					return Colours.WALNUT;
				case 8:
					return Colours.ROSE;
				case 9:
					return Colours.PLUM;
				case 10:
					return Colours.YELLOW
				case 11:
					return Colours.PEAR;
				case 12:
					return Colours.ORANGE;
				case 13:
					return Colours.VIOLET;
				case 14:
					return Colours.LIGHT_RED;
				default:
					return Colours.PURPLE;
			}
		}
		
		public static function endGame():void {
			testScores();
			
			NewgroundsConnect.postHighScore();
		}
		
		public static function testScores():void {
			if (totalScore > 3000) {
				MyGame.points3000 = true;
				NewgroundsConnect.unlockMedal("3000 Points");
			}
			if (totalScore > 3500) {
				MyGame.points3500 = true;
					NewgroundsConnect.unlockMedal("3500 Points");				
			}
			if (totalScore > 4000) {
				MyGame.points4000 = true;
				NewgroundsConnect.unlockMedal("4000 Points");
			}
		}
		
		public static function saveData():void {
			NewgroundsConnect.saveFile("aegean", aegeanDefeated.toString());
			NewgroundsConnect.saveFile("bronze", bronzeDefeated.toString());
			NewgroundsConnect.saveFile("pecan", pecanDefeated.toString());
			NewgroundsConnect.saveFile("tiger", tigerOrangeDefeated.toString());
			NewgroundsConnect.saveFile("fuchsia", fuchsiaDefeated.toString());
			NewgroundsConnect.saveFile("chartreuse", chartreuseDefeated.toString());
			NewgroundsConnect.saveFile("mahogany", mahoganyDefeated.toString());
			NewgroundsConnect.saveFile("green", greenDefeated.toString());
			NewgroundsConnect.saveFile("watermelon", watermelonDefeated.toString());
			NewgroundsConnect.saveFile("teal", tealDefeated.toString());
			NewgroundsConnect.saveFile("orange", orangeDefeated.toString());
			NewgroundsConnect.saveFile("square", squaresDefeated.toString());
			NewgroundsConnect.saveFile("twoShots", twoShotsDefeated.toString());
			NewgroundsConnect.saveFile("shotsAgainst", shotsAgainst.toString());
		}
		
	}

}