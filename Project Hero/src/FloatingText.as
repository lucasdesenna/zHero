package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	
	public class FloatingText extends Entity
	{
		private var text:Text;
		
		public function FloatingText(TEXT:String, COLOR:uint, X:int, Y:int):void
		{
			x = X;
			y = Y;
			
			Text.size = 16;
			text = new Text(TEXT);
			text.color = COLOR;
			
			graphic = text;
			Text(graphic).centerOO();
		}
		
		override public function update():void 
		{
			super.update();
			
			text.alpha -= FP.elapsed / 2;
			y -= Data.floatingextSpeed * FP.elapsed;
			
			if (text.alpha <= 0) { this.world.remove(this); }
		}
	}
}