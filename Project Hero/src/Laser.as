package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	
	public class Laser extends Weapon
	{
		private var owner:Player;
		private var angle:Number;
		private var attacking:Boolean;
		
		public function Laser():void
		{
			graphic = new Image(GFX.BASEBALL);
			
			graphic.x = -4;
			graphic.y = -2;
			Image(graphic).angle = 90;
		}
	}
}