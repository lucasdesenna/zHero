package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	public class WaveController extends Entity
	{
		public var waveCreated:Boolean;
		
		private var waveCounter:uint;
		private var waveSize:uint;
		
		private var waveTimer:Number;
		private var waveTimerLimit:Number;
		
		public function WaveController():void
		{
			waveCounter = 0;
			
			waveCreated = true;
			
			waveTimer = 0;
			waveTimerLimit = 0.5;
		}
		
		override public function update():void 
		{
			AnnouceWave();
			CreateWave();
			
			super.update();
		}
		
		private function AnnouceWave():void
		{
			if (this.world.typeCount(Data.zombieType) == 0 && this.world.classCount(WaveScreen) == 0)
			{ 
				waveCounter ++;
				waveSize = 5 * waveCounter;
				this.world.add(new WaveScreen(waveCounter, waveSize));
			}
		}
		
		private function CreateWave():void
		{
			if (waveCreated == false)
			{
				for (var wS:uint = 0; wS <= Math.round( waveSize / 4); wS++)
				{
					if (FP.rand(9) == 0)
					{
						if (waveCounter == 1)
						{
							this.world.add(new zNormal);
						}
						if (waveCounter > 1)
						{
							var specialZ:uint = FP.rand(waveCounter - 1);
							if (specialZ == 0) { this.world.add(new zFurious); }
							if (specialZ == 1) { this.world.add(new zWimp); }
							if (specialZ == 2) { this.world.add(new zFamous); }
							if (specialZ == 3) { this.world.add(new zScary); }
						}
					}
					else { this.world.add(new zNormal); }
				}
				
				waveSize -= Math.round( waveSize / 4);
				waveCreated = true;
				//trace(waveCounter);
			}
			
			if(waveCreated == true && waveSize > 0 && this.world.typeCount(Data.zombieType) > 0)
			{
				waveTimer += FP.elapsed;
				if (waveTimer >= waveTimerLimit)
				{
					if (FP.rand(9) == 0)
					{
						if (waveCounter == 1)
						{
							this.world.add(new zNormal);
						}
						if (waveCounter > 1)
						{
							specialZ = FP.rand(waveCounter - 1);
							if (specialZ == 0) { this.world.add(new zFurious); }
							if (specialZ == 1) { this.world.add(new zWimp); }
							if (specialZ == 2) { this.world.add(new zFamous); }
							if (specialZ == 3) { this.world.add(new zScary); }
						}
					}
					else { this.world.add(new zNormal); }
					waveSize --;
					waveTimer = 0;
				}
			}
		}
	}
}