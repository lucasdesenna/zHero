package
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	
	public class zFurious extends Zombie
	{
		private var attackTimer:Number = 0;
		private var timeToAttack:Number = 1;
		
		private var oscilator:Number = 0;
		private var shakeIncrement:Number = 45;
		
		public function zFurious():void
		{
			baseScore = 2;
			dropRate = 25;
			
			SetGraphics(GFX.ZFURIOUS, GFX.MASK);
		}
		
		override public function AttackCondition():Boolean 
		{
			var attackDistance:uint = width * 10;
			if (FP.distance(x, y, Data.player.x, Data.player.y) < attackDistance && onCamera == true || attackTimer > 0 && !collide(Data.zombieType, x, y) && LocateTarget().type == Data.playerType) { return true; }
			else { return false; }
		}
		
		override public function Attack():void 
		{
			attackTimer += FP.elapsed;
			
			var destination:Point = new Point;
			var speed:Number = Data.zombieSpeed * FP.elapsed * 3;
			FP.angleXY(destination, moveAngle, speed);
			
			if (attackTimer < timeToAttack) 
			{ 
				Spritemap(graphic).y += Math.sin(oscilator * Math.PI / 180);
				oscilator += shakeIncrement;
				moveAngle = FP.angle(x, y, Data.player.x, Data.player.y);
			}
			if (attackTimer >= timeToAttack)
			{
				attackTimer = timeToAttack;
				
				FP.angleXY(destination, moveAngle, speed);
				x += destination.x;
				y += destination.y;
			}
			
			Data.highEmitter.generalEmitter.emit("dust", x - 2, y - 8);
			
			var targetEntity:Entity = collideTypes(new Array(Data.zombieType, Data.playerType), x, y);
			if (targetEntity)
			{
				if (targetEntity.type == Data.zombieType)
				{ 
					undead = false;
					scored = true;
					var targetZ:Zombie = targetEntity as Zombie;
					baseScore = baseScore + targetZ.baseScore;
					targetZ.undead = false;
				}
				
				if (targetEntity.type == Data.playerType)
				{ 
					Data.highEmitter.generalEmitter.emit("stunStar", Data.player.x - 8, Data.player.y - 16);
					//this.world.add(new FloatingText("STUNNED!", Color.Red, target.x, target.y));
					Data.player.playerHealth -= Data.biteDamage;
					this.undead = false;
					Data.player.stunTimer = 0;
					Data.player.stunned = true;
				}
			}
			
			if (x > FP.screen.width - Spritemap(graphic).width || x < Spritemap(graphic).width || y > FP.screen.height - Spritemap(graphic).height || x < Spritemap(graphic).height)
			{ 
				undead = false;
				scored = true;
			}
		}
	}
}