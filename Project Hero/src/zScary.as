package
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	public class zScary extends Zombie
	{
		private var attackTimer:Number = 0;
		private var timeToAttack:Number = 1;
		
		private var oscilator:Number = 0;
		private var shakeIncrement:Number = 45;
		
		public function zScary():void
		{
			baseScore = 5;
			dropRate = 50;
			
			SetGraphics(GFX.ZSCARY, GFX.MASK);
		}
		
		override public function Attack():void 
		{
			undead = false;
			this.world.add(new ScaryScreen);
		}
		
		override public function MoveRoutine(targetEntity:Entity):void 
		{
			var destination:Point = new Point;
			moveAngle = FP.angle(x, y, Data.player.x, Data.player.y);
			FP.angleXY(destination, moveAngle, Data.playerSpeed * 3 / 4 * FP.elapsed);
			x += destination.x;
			y += destination.y;
			
			playerLKL = new Point(targetEntity.x, targetEntity.y);
		}
		
		override public function Move(targetEntity:Entity):void 
		{
			if (targetEntity)
			{
				MoveRoutine(targetEntity);
			}
		}
		
		override public function OnZombieCollision(targetEntity:Entity):void 
		{
			undead = false;
			scored = true;
			var targetZ:Zombie = targetEntity as Zombie;
			baseScore = baseScore + targetZ.baseScore;
			targetZ.undead = false;
		}
	}
}