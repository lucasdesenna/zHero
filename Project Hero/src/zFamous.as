package
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	public class zFamous extends Zombie
	{
		private var attackTimer:Number = 0;
		private var timeToAttack:Number = 2;
		
		public function zFamous():void
		{
			baseScore = 4;
			dropRate = 50;
			
			SetGraphics(GFX.ZFAMOUS, GFX.MASK);
			
			moveAngle = FP.angle(x, y, Data.player.x, Data.player.y);
		}
		
		override public function AttackCondition():Boolean 
		{
			if (attackTimer >= timeToAttack)
			{
				attackTimer = 0;
				return true;
			}
			else { return false; }
		}
		
		override public function Attack():void 
		{
			var destination:Point = new Point;
			var angle:Number = FP.rand(8) * 45;
			var distance:Number = width * 5;
			
			FP.angleXY(destination, angle, distance);
			
			for (var s:int = 0; s < 3; s++) { Data.highEmitter.generalEmitter.emit("song", x - 8 + FP.rand(9) - FP.rand(9), y - 16); }
			
			this.world.add(new zFan(this as zFamous, x + destination.x, y + destination.y));
			for (var f:int = 0; f < 8; f++) { Data.highEmitter.generalEmitter.emit("pCloud", x + destination.x - 8 + FP.rand(9) - FP.rand(9), y + destination.y + 8); }
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
				attackTimer += FP.elapsed;
			}
		}
	}
}