package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	
	public class Shotgun extends Weapon
	{
		public function Shotgun():void
		{
			Data.player.SetGraphics(GFX.SHOTGUN);
		}
	}
}