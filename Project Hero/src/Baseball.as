package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	
	public class Baseball extends Weapon
	{
		public function Baseball():void
		{
			weaponType = "melee"
			
			attackingLimit = 0.1;
			
			Data.player.SetGraphics(GFX.BASEBALL);
		}
	}
}