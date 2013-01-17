package
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import flash.display.BlendMode;
	
	public class ScaryScreen extends Entity
	{
		private var fadeIn:Boolean;
		private var timer:Number;
		
		public function ScaryScreen():void
		{
			fadeIn = true;
			timer = 0;
			
			x = FP.camera.x;
			y = FP.camera.y;
			
			graphic = new Image(GFX.SCARYOVERLAY);
			layer = -2
		}
		
		override public function update():void 
		{
			super.update();
			
			x = FP.camera.x;
			y = FP.camera.y;
			
			if (fadeIn == true)
			{
				timer += FP.elapsed;
				if (timer >= 2) { fadeIn = false; }
			}
			else
			{
				Image(graphic).alpha -= FP.elapsed;
			}
			
			if (Image(graphic).alpha <= 0)
			{
				this.world.remove(this);
			}
		}
	}
}