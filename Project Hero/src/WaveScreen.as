package
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import flash.display.BlendMode;
	
	public class WaveScreen extends Entity
	{
		
		private var waveName:Text;
		private var waveSize:Text;
		private var waveOverlay:Image;
		
		private var fadeIn:Boolean;
		
		public function WaveScreen(name:uint, size:uint):void
		{
			x = FP.camera.x;
			y = FP.camera.y;
			
			fadeIn = true;
			
			Text.size = 30;
			waveName = new Text("WAVE: " + name.toString(), FP.screen.width / 2 - 50, FP.screen.height / 4 - 10)
			//waveName.color = Color.Green;
			//waveName.centerOO();
			waveName.alpha = 0;
			
/*			Text.size = 15;
			waveSize = new Text("ZOMBIES: " + size.toString(), FP.screen.width / 2 - 50, FP.screen.height / 4 + 25 - 7.5)
			waveSize.color = Color.Green;
			//waveSize.centerOO();
			waveSize.alpha = 0;*/
			
			waveOverlay = new Image(new BitmapData(FP.screen.width, FP.screen.height / 8 + 5, false, Color.Black));
			waveOverlay.y = FP.screen.height / 5;
			waveOverlay.blend = BlendMode.MULTIPLY;
			waveOverlay.alpha = 0;
			
			graphic = new Graphiclist(waveOverlay,waveName);
			layer = -2
		}
		
		override public function update():void 
		{
			super.update();
			
			x = FP.camera.x;
			y = FP.camera.y;
			
			Data.player.Regen();
			
			if (fadeIn == true)
			{
				waveName.alpha += FP.elapsed / 2;
				//waveSize.alpha += FP.elapsed / 2;
				waveOverlay.alpha += FP.elapsed / 2;
				if (waveName.alpha >= 1) { fadeIn = false; }
			}
			else
			{
				waveName.alpha -= FP.elapsed;
				//waveSize.alpha -= FP.elapsed;
				waveOverlay.alpha -= FP.elapsed;
			}
			
			if (waveName.alpha <= 0)
			{
				this.world.remove(this);
				Data.waveController.waveCreated = false;
			}
		}
	}
}