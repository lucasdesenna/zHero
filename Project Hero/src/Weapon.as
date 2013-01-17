package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	
	public class Weapon extends Entity
	{
		public var weaponType:String;
		
		public var attacking:Boolean
		public var attackingLimit:Number;
		private var attackingTimer:Number;
		
		public function Weapon():void
		{
			attacking = false;
			attackingTimer = 0;
		}
		
		override public function render():void 
		{
			if (this.world)
			{
				Attack();
			}
			
			super.render();
		}
		
		public function Attack():void
		{
			if (weaponType == "melee")
			{
				if (attacking == false)
				{
					attackingTimer = 0;
				}
				else
				{ 
					attackingTimer += FP.elapsed;
					if (attackingTimer >= attackingLimit)
					{
						attackingTimer = attackingLimit;
						attacking = false;					
					}
				}
			}
			
			if (weaponType == "firearm")
			{
				if (attacking == false)
				{
					attackingTimer = 0;
				}
				else
				{ 
					if (attackingTimer == 0) { this.world.add(new Bullet(Data.player.x, Data.player.y, FP.angle(Data.player.x, Data.player.y, Input.mouseX, Input.mouseY))); }
					attackingTimer += FP.elapsed;
					if (attackingTimer >= attackingLimit)
					{
						attackingTimer = attackingLimit;
						attacking = false;					
					}
				}
			}
		}
		
		public function AttackCondition():Zombie
		{
			var z:Zombie;
			
			if (weaponType == "melee")
			{
				z = Zombie(Data.player.collide(Data.zombieType, Data.player.x, Data.player.y));
			}
			
			if (weaponType == "firearm")
			{
				if (Input.mouseDown) { z = Zombie(Data.player.collide(Data.zombieType, Input.mouseX, Input.mouseY)); }
			}
			return z;
		}
		
	}
}