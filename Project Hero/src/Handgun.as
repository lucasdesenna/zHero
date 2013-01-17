package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	
	public class Handgun extends Weapon
	{
		public function Handgun():void
		{
			weaponType = "firearm";
			
			attackingLimit = 0.1;
			
			Data.player.SetGraphics(GFX.HANDGUN);
		}
		
	}
}