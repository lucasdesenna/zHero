package
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import flash.display.BlendMode;
	
	public class DeathScreen extends Entity
	{
		public function DeathScreen():void
		{
			x = FP.camera.x;
			y = FP.camera.y;
			
			Text.size = 20;
			const deathText:Text = new Text("You are Dead!", FP.screen.width / 2, FP.screen.height / 2)
			deathText.color = Color.Red;
			deathText.centerOO();
			
			const deathOverlay:Image = new Image(new BitmapData(FP.screen.width, FP.screen.height, false, Color.Black));
			deathOverlay.blend = BlendMode.MULTIPLY;
			deathOverlay.alpha = 0.5;
			
			graphic = new Graphiclist(deathOverlay, deathText);
			layer = -2
		}
	}
}