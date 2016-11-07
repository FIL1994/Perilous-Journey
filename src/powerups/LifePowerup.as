package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import com.newgrounds.BitmapLoader;
	import flash.display.Bitmap;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import flash.geom.Point;
    import net.flashpunk.graphics.Image;
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Philip VR
	 */
	public class LifePowerup extends Entity 
	{
		[Embed(source="../../assets/powerups/lifePowerup.png")] private const POWERUP_GRAPHIC:Class;
		
		public function LifePowerup(x:Number=0, y:Number=0) 
		{
			graphic = new Image(POWERUP_GRAPHIC);
			
			type = "lifePowerup";
			
			setHitboxTo(graphic);
			
			super(x, y, graphic, mask);
		}
		
		public function destroy():void
        {
			MyGame.lives++;
            graphic = null;
			FP.world.remove(this);
        }
		
		override public function update():void 
		{
			if (collide("player", x, y)) {
				destroy();
			}
			
		}
		
	}

}