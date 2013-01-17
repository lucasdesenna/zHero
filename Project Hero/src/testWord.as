package  
{
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class testWord extends World
	{
		public function testWord():void
		{
			Data.player = new Player;
		}
		
		override public function begin():void
		{
			//add(new Scenery);
			add(Data.player);
			add(Data.lowEmitter);
			add(Data.highEmitter);
			add(new HealthBar);
			
			add(Data.scoreKeeper);
			add(Data.crowdController);
			add(Data.waveController);
		}
		
		
		override public function update():void 
		{
			super.update();
			//updateCamera();
			//trace(FP.world.typeCount(Data.zombieType));
		}
		
		private function updateCamera():void
		{
			camera.x = Data.player.x - FP.screen.width / 2;
			camera.y = Data.player.y - FP.screen.height / 2;
			
			if (FP.camera.x <= 0) { FP.camera.x = 0; }
			if (FP.camera.x >= Data.sceneryWidth - FP.screen.width) { FP.camera.x = Data.sceneryWidth - FP.screen.width; }
			if (FP.camera.y <= 0) { FP.camera.y = 0; }
			if (FP.camera.y >= Data.sceneryHeight - FP.screen.height) { FP.camera.y = Data.sceneryHeight - FP.screen.height; }
		}
	}
}