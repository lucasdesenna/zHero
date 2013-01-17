package
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	
	public class HealthBar extends Entity
	{
		public function HealthBar():void
		{
			
		}
		
		override public function render():void 
		{
			x = 17 + FP.camera.x;
			y = 35 + FP.camera.y;
			
			if (Data.player)
			{
				Draw.rectPlus(x, y, 86, 3, Color.DarkGray);
				Draw.rectPlus(x, y, 86 * (Data.player.playerHealth / Data.playerMaxHealth), 3, Color.Red);
			}
			
			super.render();
		}
	}
}