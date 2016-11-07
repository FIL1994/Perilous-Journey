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
	import Player;
	
	/**
	 * ...
	 * @author Philip VR
	 */
	public class BulletsPowerup extends Entity 
	{
		[Embed(source="../../assets/powerups/bulletsPowerup.png")] private const POWERUP_GRAPHIC:Class;
		
		public function BulletsPowerup(x:Number=0, y:Number=0) 
		{
			graphic = new Image(POWERUP_GRAPHIC);
			
			type = "bulletsPowerup";
			
			setHitboxTo(graphic);
			
			super(x, y, graphic, mask);
		}
		
		public function destroy():void
        {
            graphic = null;
			FP.world.remove(this);
        }
		
		override public function update():void 
		{
			if (collide("player", x, y)) {
				Player.extraBullets = true;
				Player.bulletsStartFrame = 0;
				Player.frameToStopExtraBullets = 155;
				destroy();
			}
			
		}
		
	}

}