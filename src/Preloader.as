package
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import flash.display.Bitmap;
	import flash.text.Font;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	
	[SWF(width = "640", height = "480")]
	
	/**
	 * ...
	 * @author Philip VR
	 */
	public class Preloader extends MovieClip 
	{
		public static var stage:Stage;
		public static var ad:DisplayObject;
		
		private const CLICK_TO_CONTINUE:Boolean = true;
		
		private var square:Sprite = new Sprite();
		private var border:Sprite = new Sprite();
		private var size:Number = 256;
		private var text:TextField = new TextField();

		private var txtColor:uint = 0xFFFFFF;
		private var loaderColor:uint = 0xD8D8D8;
		
		// Backdrop
		[Embed(source="../assets/BackgroundEmpty.png")] static private var imgBackground:Class;
		private var backdrop:Bitmap = new imgBackground;			
		
		// Click to continue
		[Embed(source='../assets/gfx/click_to_continue.png')] static private var imgClick:Class;
		private var clickSprite:Bitmap = new imgClick;
		
		private var gameName:TextField = new TextField();
		private var instructions:TextField = new TextField();
		
		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			
			NewgroundsConnect.container = this;
			NewgroundsConnect.init(stage);
			
			// background
			addChild(backdrop);
			
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			addChild(square);
			square.x = (stage.stageWidth / 2) -((size-8)/2);
			square.y = stage.stageHeight / 2 + 40;
			
			addChild(border);
			border.x = (stage.stageWidth / 2) - (size/2);
			border.y = stage.stageHeight / 2 - 4 + 40;
		
			addChild(text);
			text.x = (stage.stageWidth / 2) - (size/2);
			text.y = stage.stageHeight / 2 - 30 + 40;
			
			gameName.defaultTextFormat = new TextFormat("Iceland", 45, Colours.CRIMSON, true);
			gameName.defaultTextFormat.align = TextFormatAlign.CENTER;
			gameName.embedFonts = true;
			gameName.text = "Perilous Journey";
			gameName.y = stage.height / 3 - 80;
			gameName.x = (stage.width / 2) - (gameName.textWidth /5) + 10;
			gameName.autoSize = TextFieldAutoSize.CENTER;
			
			addChild(gameName);
			
			instructions.defaultTextFormat = new TextFormat("Iceland", 19, Colours.GRAY, true);
			instructions.defaultTextFormat.align = TextFormatAlign.CENTER;
			instructions.embedFonts = true;
			instructions.text = "Use the arrow keys or WASD to move\n            Press spacebar to shoot" +
			"\n          Press M to mute the game";
			instructions.y = stage.height / 3;
			instructions.x = (stage.width / 2) - (instructions.textWidth /5);
			instructions.autoSize = TextFieldAutoSize.CENTER;
			
			addChild(instructions);
			
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// update loader
			square.graphics.beginFill(loaderColor);
			square.graphics.drawRect(0,0,(loaderInfo.bytesLoaded / loaderInfo.bytesTotal) * (size-8),20);
			square.graphics.endFill();
			
			border.graphics.lineStyle(2, loaderColor);
			border.graphics.drawRect(0, 0, size, 28);
			
			text.textColor = Colours.SNOW;
			text.text = "Loading: " + Math.ceil((loaderInfo.bytesLoaded / loaderInfo.bytesTotal) * 100) + "%";
			
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				removeEventListener(Event.ENTER_FRAME, checkFrame);
				loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
				if (CLICK_TO_CONTINUE) {
					addChild(clickSprite);
					clickSprite.x = (stage.stageWidth / 2) - clickSprite.width / 2;
					clickSprite.y = 360;
					stage.addEventListener(MouseEvent.CLICK, clickStartup);
				}
				else{					
					stop();
					loadingFinished();
				}
				
			}
		}
		
		private function clickStartup(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.CLICK, clickStartup);
			startup();
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			
			startup();
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}