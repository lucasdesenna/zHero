package
{
	import net.flashpunk.FP;
	import net.flashpunk.Engine;
	import net.flashpunk.utils.Key;
	import flash.ui.Mouse;

	public class Main extends Engine
	{	
		public function Main()
		{
			super(211, 317, 60, false);
			//FP.console.enable();
			//Mouse.hide();
			FP.console.toggleKey = Key.F1;
			
			FP.world = new testWord;
		}
		
		override public function init():void
		{
			trace("FlashPunk has started successfully!");
		}
	}
}