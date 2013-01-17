package
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.Input;
	
	public class Player extends Entity
	{
		public var moveAngle:Number;
		
		public var weapon:Weapon;
		public var weaponReady:Boolean;
		public var weaponTimer:Number;
		
		public var playerHealth:Number;
		public var playerAlive:Boolean;
		public var stunned:Boolean;
		
		private var bloodTimer:Number;
		public var stunTimer:Number;
		
		public var allGraphics:Vector.<Graphic>;
		
		public function Player():void
		{
			playerAlive = true;
			weaponReady = true;
			stunned = false;
			weaponTimer = 0;
			
			playerHealth = Data.playerMaxHealth;
			bloodTimer = 0;
			
			x = FP.screen.width / 2;
			y = FP.screen.height / 2;
			
			SetGraphics(GFX.BASEBALL);
			
			type = Data.playerType;
			setHitbox(16, 16, 8, 8);
		}
		
		public function SetGraphics(playerGFX:Class = null):void
		{
			if (playerGFX)
			{
				allGraphics = new Vector.<Graphic>;
				allGraphics.length = 2;
				
				//Player
				allGraphics[0] = new Spritemap(playerGFX, 32, 32);
				Spritemap(allGraphics[0]).tinting = 0;
				Spritemap(allGraphics[0]).color = Color.Red;
				
				Spritemap(allGraphics[0]).add("standFront", [0], 1, false);
				Spritemap(allGraphics[0]).add("standFrontLeft", [4], 1, false);
				Spritemap(allGraphics[0]).add("standLeft", [8], 1, false);
				Spritemap(allGraphics[0]).add("standBackLeft", [12], 1, false);
				Spritemap(allGraphics[0]).add("standBack", [16], 1, false);
				Spritemap(allGraphics[0]).add("standBackRight", [20], 1, false);
				Spritemap(allGraphics[0]).add("standRight", [24], 1, false);
				Spritemap(allGraphics[0]).add("standFrontRight", [28], 1, false);
				
				Spritemap(allGraphics[0]).add("runFront", [1, 2], 4);
				Spritemap(allGraphics[0]).add("runFrontLeft", [5, 6], 4);
				Spritemap(allGraphics[0]).add("runLeft", [9, 10], 4);
				Spritemap(allGraphics[0]).add("runBackLeft", [13, 14], 4);
				Spritemap(allGraphics[0]).add("runBack", [17, 18], 4);
				Spritemap(allGraphics[0]).add("runBackRight", [21, 22], 4);
				Spritemap(allGraphics[0]).add("runRight", [25, 26], 4);
				Spritemap(allGraphics[0]).add("runFrontRight", [29, 30], 4);
				
				Spritemap(allGraphics[0]).add("hitFront", [3], 1);
				Spritemap(allGraphics[0]).add("hitFrontLeft", [7], 1);
				Spritemap(allGraphics[0]).add("hitLeft", [11], 1);
				Spritemap(allGraphics[0]).add("hitBackLeft", [15], 1);
				Spritemap(allGraphics[0]).add("hitBack", [19], 1);
				Spritemap(allGraphics[0]).add("hitBackRight", [23], 1);
				Spritemap(allGraphics[0]).add("hitRight", [27], 1);
				Spritemap(allGraphics[0]).add("hitFrontRight", [31], 1);
				
				Spritemap(allGraphics[0]).centerOO();
				
				//Overlay
				allGraphics[1] = new Image(GFX.HIT_OVERLAY);
				Image(allGraphics[1]).relative = false;
				Image(allGraphics[1]).alpha = 0;
				
				//trace(allGraphics[0]);
				
				graphic = new Graphiclist(allGraphics[0], allGraphics[1]);
				
				layer = -1;
			}
		}
		
		override public function added():void 
		{
			super.added();
			
			weapon = new Baseball();
			//weapon = new Handgun();
			this.world.add(weapon);
		}
		
		override public function render():void 
		{
			if (stunned == true)
			{
				moveAngle += 720 * FP.elapsed;
				if (moveAngle > 360) { moveAngle -= 360; }
			}
			else
			{
				if (FP.distance(x, y, Input.mouseX + FP.camera.x, Input.mouseY + FP.camera.y) >= Data.playerSpeed * FP.elapsed && Input.mouseDown == true && weapon.attacking == false)
				{
					if (moveAngle <= 22.5 || moveAngle >= 337.5) { Spritemap(allGraphics[0]).play("runRight"); }
					if (moveAngle < 67.5 && moveAngle > 22.5) { Spritemap(allGraphics[0]).play("runBackRight"); }
					if (moveAngle <= 112.5 && moveAngle >= 67.5) { Spritemap(allGraphics[0]).play("runBack"); }
					if (moveAngle < 157.5 && moveAngle > 112.5) { Spritemap(allGraphics[0]).play("runBackLeft"); }
					if (moveAngle <= 202.5 && moveAngle >= 157.5) { Spritemap(allGraphics[0]).play("runLeft"); }
					if (moveAngle < 247.5 && moveAngle > 202.5) { Spritemap(allGraphics[0]).play("runFrontLeft"); }
					if (moveAngle <= 292.5 && moveAngle >= 247.5) { Spritemap(allGraphics[0]).play("runFront"); }
					if (moveAngle < 337.5 && moveAngle > 292.5) { Spritemap(allGraphics[0]).play("runFrontRight"); }
				}
				
				if (weapon.attacking == true)
				{
					if (moveAngle <= 22.5 || moveAngle >= 337.5) { Spritemap(allGraphics[0]).play("hitRight"); }
					if (moveAngle < 67.5 && moveAngle > 22.5) { Spritemap(allGraphics[0]).play("hitBackRight"); }
					if (moveAngle <= 112.5 && moveAngle >= 67.5) { Spritemap(allGraphics[0]).play("hitBack"); }
					if (moveAngle < 157.5 && moveAngle > 112.5) { Spritemap(allGraphics[0]).play("hitBackLeft"); }
					if (moveAngle <= 202.5 && moveAngle >= 157.5) { Spritemap(allGraphics[0]).play("hitLeft"); }
					if (moveAngle < 247.5 && moveAngle > 202.5) { Spritemap(allGraphics[0]).play("hitFrontLeft"); }
					if (moveAngle <= 292.5 && moveAngle >= 247.5) { Spritemap(allGraphics[0]).play("hitFront"); }
					if (moveAngle < 337.5 && moveAngle > 292.5) { Spritemap(allGraphics[0]).play("hitFrontRight"); }
				}
				
				if (FP.distance(x, y, Input.mouseX + FP.camera.x, Input.mouseY + FP.camera.y) <= Data.playerSpeed * FP.elapsed || Input.mouseDown == false)
				{
					if (moveAngle <= 22.5 || moveAngle >= 337.5) { Spritemap(allGraphics[0]).play("standRight"); }
					if (moveAngle < 67.5 && moveAngle > 22.5) { Spritemap(allGraphics[0]).play("standBackRight"); }
					if (moveAngle <= 112.5 && moveAngle >= 67.5) { Spritemap(allGraphics[0]).play("standBack"); }
					if (moveAngle < 157.5 && moveAngle > 112.5) { Spritemap(allGraphics[0]).play("standBackLeft"); }
					if (moveAngle <= 202.5 && moveAngle >= 157.5) { Spritemap(allGraphics[0]).play("standLeft"); }
					if (moveAngle < 247.5 && moveAngle > 202.5) { Spritemap(allGraphics[0]).play("standFrontLeft"); }
					if (moveAngle <= 292.5 && moveAngle >= 247.5) { Spritemap(allGraphics[0]).play("standFront"); }
					if (moveAngle < 337.5 && moveAngle > 292.5) { Spritemap(allGraphics[0]).play("standFrontRight"); }
				}
			}
			
			//Image(allGraphics[1]).x = FP.camera.x;
			//Image(allGraphics[1]).y = FP.camera.y;
			
			super.render();
		}
		
		override public function update():void 
		{
			super.update();
			if (stunned == false)
			{
				Refresh();
				Move();
			}
			Burn();
			Bleed();
			Stunned();
			PowerUp();
		}
		
		private function Move():void
		{
			if (playerAlive == true)
			{
				var z:Zombie = weapon.AttackCondition();
				
				if (FP.distance(x, y, Input.mouseX + FP.camera.x, Input.mouseY + FP.camera.y) >= Data.playerSpeed * FP.elapsed && z == null && Input.mouseDown == true)
				{
					var destination:Point = new Point;
					moveAngle = FP.angle(x, y, Input.mouseX + FP.camera.x, Input.mouseY + FP.camera.y);
					
					FP.angleXY(destination, moveAngle, Data.playerSpeed);
					
					if (!collide(Data.mapType, x + destination.x * FP.elapsed,  y + destination.y * FP.elapsed))
					{
						x = x + destination.x * FP.elapsed;
						y = y + destination.y * FP.elapsed;
					}
				}
				
				if (z != null)
				{
					Fight(z);
				}
				
				clampHorizontal(0, FP.screen.width);
				clampVertical(0, FP.screen.height);
			}
		}
		
		private function Fight(target:Zombie):void
		{
			if (weaponReady == true)
			{
				weapon.attacking = true;
				target.undead = false;
				target.scored = true;
				weaponReady = false;
			}	
			
			else
			{
				var pRetreat:Point = new Point;
				var pRetreatAngle:Number = FP.angle(x, y, target.x, target.y);
				
				FP.angleXY(pRetreat, pRetreatAngle, - Data.playerSpeed);
				x += pRetreat.x * FP.elapsed;
				y += pRetreat.y * FP.elapsed;
			}
		}
		
		public function Regen():void
		{
			if (playerHealth > 0 && playerHealth < Data.playerMaxHealth)
			{
				playerHealth += Data.playerRegenRate * FP.elapsed;
				if (playerHealth >= Data.playerMaxHealth) { playerHealth = Data.playerMaxHealth; }
			}
		}
		
		public function Stunned():void
		{
			if (stunned == true)
			{
				stunTimer += FP.elapsed;
				weaponReady = false;
				
				if (stunTimer >= Data.stunLimitT)
				{
					stunTimer = Data.stunLimitT;
					stunned = false;
					weaponReady = true;
				}
			}
		}
		
		private function Bleed():void
		{
			if (playerHealth < Data.playerMaxHealth / 3 && playerAlive == true)
			{
				bloodTimer += 800 * FP.elapsed;
				if (bloodTimer >= playerHealth)
				{
					bloodTimer = 0;
					Data.lowEmitter.generalEmitter.emit("bloodTrail", x + FP.rand(4) - FP.rand(4) , y + FP.rand(4) - FP.rand(4));
				}
			}
			
			if (playerAlive == false)
			{
				bloodTimer += FP.elapsed;
				if (bloodTimer >= 1)
				{
					bloodTimer = 0;
					Data.lowEmitter.generalEmitter.emit("bloodSplashP", x - 16 + FP.rand(32) - FP.rand(32), y - 16 + FP.rand(32) - FP.rand(32));
				}
			}
		}
		
		private function Refresh():void
		{
			if (playerHealth <= 0 && playerAlive == true)
			{
				playerHealth = 0;
				playerAlive = false;
				this.world.add(new DeathScreen);
			}
			
			if (playerHealth > 0 && playerHealth <= Data.playerMaxHealth && playerAlive == true && Image(allGraphics[1]).alpha > 0)
			{
				Image(allGraphics[1]).alpha -= FP.elapsed;
				if (Image(allGraphics[1]).alpha < 0) { Image(allGraphics[1]).alpha = 0; }
			}
			
			if (weaponReady == false)
			{
				weaponTimer += FP.elapsed;
				
				if (weaponTimer >= Data.batRechargeT)
				{
					weaponTimer = 0;
					weaponReady = true;
				}
			}
			
			if (Spritemap(allGraphics[0]).tinting > 0)
			{
				Spritemap(allGraphics[0]).tinting -= 2 * FP.elapsed;
				if (Spritemap(allGraphics[0]).tinting < 0) { Spritemap(allGraphics[0]).tinting = 0; }
			}
		}
		
		private function Burn():void
		{
			if (collide(Data.gooType, x, y))
			{
				//trace("burning");
				playerHealth -= Data.gooDamage * FP.elapsed;
				Data.scoreKeeper.BreakCombo();
				FlashOverlay();
			}
		}
		
		public function FlashOverlay():void
		{
			Spritemap(allGraphics[0]).tinting = 1;
			Image(allGraphics[1]).alpha = 1;
		}
		
		public function PowerUp():void
		{
			var power:Power = Entity(collideTypes(Data.powerType, x, y)) as Power;
			
			if (power)
			{
				//trace("powerUp");
				if (power.power == "handgun")
				{
					trace(power.power);
				}
				if (power.power == "shotgun")
				{
					trace(power.power);
				}
				if (power.power == "sniper")
				{
					trace(power.power);
				}
				if (power.power == "laser")
				{
					trace(power.power);
				}
				if (power.power == "grenade")
				{
					trace(power.power);
				}
				if (power.power == "molotov")
				{
					trace(power.power);
				}
				if (power.power == "flail")
				{
					trace(power.power);
				}
				if (power.power == "sledgehammer")
				{
					trace(power.power);
				}
				if (power.power == "katana")
				{
					trace(power.power);
				}
				if (power.power == "airstrike")
				{
					trace(power.power);
				}
				if (power.power == "armor")
				{
					trace(power.power);
				}
			}
		}
	}
}