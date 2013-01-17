package
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	public class zWimp extends Zombie
	{
		private var attackTimer:Number = 0;
		private var timeToAttack:Number = 0.25;
		
		public function zWimp():void
		{
			baseScore = 3;
			dropRate = 30;
			
			SetGraphics(GFX.ZWIMP, GFX.MASK);
			
			moveAngle = FP.angle(x, y, Data.player.x, Data.player.y);
		}
		
		override public function MoveRoutine(targetEntity:Entity):void 
		{
			var destination:Point = new Point;
			var speed:Number = Data.zombieSpeed * FP.elapsed;
			moveAngle += Math.random() * 15 + Math.random() * -15;
			if (moveAngle > 360) { moveAngle -= 360; }
			
			FP.angleXY(destination, moveAngle, speed);
			
			if (!collide(Data.zombieType, x + destination.x, y + destination.y))
			{
				x += destination.x;
				y += destination.y;
			}
			else
			{
				moveAngle += 180;
				if (moveAngle > 360) { moveAngle -= 360; }
				FP.angleXY(destination, moveAngle, speed);
				x += destination.x;
				y += destination.y;
			}
		}
		
		override public function Move(targetEntity:Entity):void 
		{
			if (targetEntity)
			{ 
				MoveRoutine(targetEntity);
				LeaveGoo();
			}
		}
		
		public function LeaveGoo():void
		{
			attackTimer += FP.elapsed;
			
			if (attackTimer >= timeToAttack)
			{
				attackTimer = 0;
				
				var destination:Point = new Point;
				var distance:Number = -halfWidth;
				
				FP.angleXY(destination, moveAngle, distance);
				
				this.world.add(new Goo(x + destination.x, y + destination.y));
			}
		}
	}
}