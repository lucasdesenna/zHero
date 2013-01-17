package
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	
	public class Tracer extends Entity
	{
		//private var i:Image;

		private var x1:Number;
		private var y1:Number;
		private var x2:Number;
		private var y2:Number;
		private var a:Number;
		private var t:Number;
		
		public function Tracer(_x1:int, _y1:int, _x2:int, _y2:int, _t:Number):void
		{
			x1 = _x1;
			y1 = _y1;
			x2 = _x2;
			y2 = _y2;
			a = 0.2;
			t = _t;
			t = 1 / t;
			//i = new Image(Data.tracerImage);
			//graphic = i;
			Draw.linePlus(x1, y1, x2, y2, 0xFFFFFF, a);
		}
		override public function update():void
		{
			a -= t * FP.elapsed;
			if (a <= 0) { this.world.remove(this); }
		}
		
		override public function render():void
		{
			
			Draw.linePlus(x1, y1, x2, y2, 0xFFFFFF, a);
		}
	}
}