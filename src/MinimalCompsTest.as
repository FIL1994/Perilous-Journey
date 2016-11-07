package 
{
	import com.bit101.components.PushButton;
	import flash.display.Bitmap;
	import net.flashpunk.FP
	import net.flashpunk.World;
	import flash.display.Stage;
	import net.flashpunk.Engine;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	import com.bit101.components.Knob;
	import com.bit101.components.ComboBox;
	import com.bit101.components.WheelMenu;
	import com.bit101.components.Window;
	import com.bit101.components.PushButton;
	import com.bit101.components.Meter;
	import com.bit101.components.ColorChooser;
	
	/**
	 * ...
	 * @author Philip VR
	 */
	public class MinimalCompsTest extends World
	{
		
		private var knob:Knob = new Knob(null, 50, 50, "This is a knob", null);
		private static var window:Window = new Window(null, 275, 75, "Test Window");
		private var meter:Meter = new Meter(window, 0, 20, "myMeter");
		
		private var windowColourFunction:Function = MinimalCompsTest["changeWindowColour"];
		private var myFunction:Function = function():void { changeWindowColour(); };
		
		private var pushButton:PushButton = new PushButton(window, 0, 0, "Press", myFunction);
		private var colourChooser:ColorChooser = new ColorChooser(null, 125, 100, Colours.MAHOGANY, null);
		
		private var stringArray:Array = new Array("1", "2", "3", "4", "5", "6", "7", "8", "9", "0");
		private var comboBox:ComboBox = new ComboBox(null, 120, 50, "Select a number", stringArray);
		
		private static var changeColour:Boolean = false;
		
		public function MinimalCompsTest() 
		{
			FP.screen.color = Colours.TURQUOISE;
		}
		
		override public function begin():void 
		{
			pushButton.setSize(200, 20);
			
			window.setSize(200, 200);
			window.hasCloseButton = true;
			window.hasMinimizeButton = true;
			window.color = Colours.PEAR;
			
			meter.setSize(200, 20);
			meter.minimum = 0;
			meter.maximum = 100;
			meter.showValues = true;
			
			FP.stage.addChild(knob);
			FP.stage.addChild(comboBox);
			FP.stage.addChild(colourChooser);
			FP.stage.addChild(window);
			
			super.begin();
		}
		
		override public function update():void 
		{
			super.update();
			
			meter.value = knob.value;
		}
		
		private static function changeWindowColour(stringThatDoesNothing:String = ""): void {
			changeColour = !changeColour;
			
			if(changeColour)
				window.color = Colours.LIME;
			else
				window.color = Colours.PEAR;
		}
		
	}

}