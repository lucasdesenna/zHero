package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	
	public class Sniper extends Weapon
	{
		public function Sniper():void
		{
			Data.player.SetGraphics(GFX.SNIPER);
		}
	}
}