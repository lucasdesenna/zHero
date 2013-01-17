package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import flash.geom.Point;
	
	public class zFan extends Zombie
	{
		private var leader:zFamous;
		
		public function zFan(_leader:zFamous, _x:int, _y:int):void
		{
			leader = _leader;
			dropRate = 10;
			
			SetGraphics(GFX.ZFAN, GFX.MASK);
			
			x = _x;
			y = _y;
		}
		
		
		override public function MoveRoutine(targetEntity:Entity):void 
		{
			if (FP.distance(leader.x, leader.y, Data.player.x, Data.player.y) >= Data.zFamousAttackDist && leader.world)
			{
				var destination:Point = new Point;
				var speed:Number = Data.zombieSpeed * FP.elapsed;
				moveAngle = leader.moveAngle;
				
				FP.angleXY(destination, moveAngle, speed);
				
				if (!collide(Data.zombieType, x + destination.x, y + destination.y))
				{
					x += destination.x;
					y += destination.y;
				}
			}
			else { super.MoveRoutine(targetEntity); }
		}
		
		override public function Spawn():void 
		{
			
		}
	}
}