package
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Pixelmask;
	
	public class Zombie extends Entity
	{
		public var undead:Boolean;
		private var zombieIndex:String;
		
		private var playerLKL:Point;
		private var oldX:Number;
		private var oldY:Number;
		
		private var waypoints:Array;
		protected var moveAngle:Number;
		
		protected var biteReady:Boolean;
		private var biteTimer:Number;
		
		private var roamTimer:Number;
		private var roamLimit:Number;
		private var roamAngle:Number;
		
		private var panicCounter:Number;
		
		public function Zombie(gfx:Class):void
		{
			undead = true;
			
			biteReady = true;
			biteTimer = 0;
			
			roamLimit = 1 + Math.random() * 2;
			roamTimer = 0;
			roamAngle = Math.random() * 360;
			
			SetGraphics(GFX.ZOMBIE, GFX.MASK);
			
			Spawn();
			
			waypoints = new Array;
			playerLKL = new Point(x, y);
			waypoints[0] = playerLKL;
		}
		
		protected function SetGraphics(gfx:Class, _mask:Class):void
		{
			graphic = new Spritemap(gfx, 16, 16);
			Spritemap(graphic).add("standFront", [0], 1, false);
			Spritemap(graphic).add("standFrontLeft", [3], 1, false);
			Spritemap(graphic).add("standLeft", [6], 1, false);
			Spritemap(graphic).add("standBackLeft", [9], 1, false);
			Spritemap(graphic).add("standBack", [12], 1, false);
			Spritemap(graphic).add("standBackRight", [15], 1, false);
			Spritemap(graphic).add("standRight", [18], 1, false);
			Spritemap(graphic).add("standFrontRight", [21], 1, false);
			
			Spritemap(graphic).add("runFront", [1, 2], 4);
			Spritemap(graphic).add("runFrontLeft", [4, 5], 4);
			Spritemap(graphic).add("runLeft", [7, 8], 4);
			Spritemap(graphic).add("runBackLeft", [10, 11], 4);
			Spritemap(graphic).add("runBack", [13, 14], 4);
			Spritemap(graphic).add("runBackRight", [16, 17], 4);
			Spritemap(graphic).add("runRight", [19, 20], 4);
			Spritemap(graphic).add("runFrontRight", [22, 23], 4);
			
			Spritemap(graphic).centerOO();
			
			layer = 1;
			
			type = Data.zombieType;
			setHitbox(Image(graphic).width, Image(graphic).height, Image(graphic).width / 2, Image(graphic).height / 2);
			width = Image(graphic).width;
			mask = new Pixelmask(_mask, -Image(graphic).width / 2, -Image(graphic).height / 2 );
		}
		
		override public function added():void 
		{
			if (Data.zombieCount < 10) { zombieIndex = "0" + "0" + "0" + Data.zombieCount.toString(); }
			if (Data.zombieCount > 10 && Data.zombieCount < 100) { zombieIndex = "0" + "0" + Data.zombieCount.toString(); }
			if (Data.zombieCount > 100 && Data.zombieCount < 1000) { zombieIndex = "0" + Data.zombieCount.toString(); }
			//trace(zombieIndex);
			
			Data.zombieCount ++;
			if (Data.zombieCount > 1000) { Data.zombieCount = 0; }
			
			Data.crowdController.zombieList[zombieIndex] = this as Zombie;
			//trace(Data.crowdController.zombieList[zombieIndex]);
			
			super.added();
		}
		
		override public function render():void 
		{
			if (this.world)
			{
				if (x != oldX || y != oldY)
				{
					if (moveAngle <= 22.5 || moveAngle >= 337.5) { Spritemap(graphic).play("runRight"); }
					if (moveAngle < 67.5 && moveAngle > 22.5) { Spritemap(graphic).play("runBackRight"); }
					if (moveAngle <= 112.5 && moveAngle >= 67.5) { Spritemap(graphic).play("runBack"); }
					if (moveAngle < 157.5 && moveAngle > 112.5) { Spritemap(graphic).play("runBackLeft"); }
					if (moveAngle <= 202.5 && moveAngle >= 157.5) { Spritemap(graphic).play("runLeft"); }
					if (moveAngle < 247.5 && moveAngle > 202.5) { Spritemap(graphic).play("runFrontLeft"); }
					if (moveAngle <= 292.5 && moveAngle >= 247.5) { Spritemap(graphic).play("runFront"); }
					if (moveAngle < 337.5 && moveAngle > 292.5) { Spritemap(graphic).play("runFrontRight"); }
				}
				
				else 
				{
					if (moveAngle <= 22.5 || moveAngle >= 337.5) { Spritemap(graphic).play("standRight"); }
					if (moveAngle < 67.5 && moveAngle > 22.5) { Spritemap(graphic).play("standBackRight"); }
					if (moveAngle <= 112.5 && moveAngle >= 67.5) { Spritemap(graphic).play("standBack"); }
					if (moveAngle < 157.5 && moveAngle > 112.5) { Spritemap(graphic).play("standBackLeft"); }
					if (moveAngle <= 202.5 && moveAngle >= 157.5) { Spritemap(graphic).play("standLeft"); }
					if (moveAngle < 247.5 && moveAngle > 202.5) { Spritemap(graphic).play("standFrontLeft"); }
					if (moveAngle <= 292.5 && moveAngle >= 247.5) { Spritemap(graphic).play("standFront"); }
					if (moveAngle < 337.5 && moveAngle > 292.5) { Spritemap(graphic).play("standFrontRight"); }
				}
				
				oldX = x;
				oldY = y;
				super.render();
			}
		}
		
		public function SuperRefresh():void
		{
			if (x < 0 || x > FP.camera.x + FP.screen.width || y < 0 || y > FP.camera.y + FP.screen.height) { EnterStage(); }
			else
			{
				if (undead == false) { Die(); }
				else
				{
					Refresh();
					Move();
				}
			}
		}
		
		public function Refresh():void
		{
			if (biteReady == false)
			{
				biteTimer += FP.elapsed;
				if (biteTimer >= Data.biteRechargeT)
				{
					biteTimer = 0;
					biteReady = true;
				}
			}
		}
		
		public function LocateTarget():Entity
		{
			//Returns Entity seen when looking at the player
			
			var targetEntity:Entity;
			var targetLocation:Point;
			var targetTypes:Array = new Array(Data.playerType, Data.zombieType, Data.mapType);
			
			var searchStep:Number = halfWidth;
			var searchDistance:int = FP.screen.height;
			
			var x0:Number = x;
			var y0:Number = y;
			
			targetEntity = Entity(collideTypes(targetTypes, x, y));
			if (targetEntity)
			{
				if (targetEntity.type == Data.zombieType || targetEntity.type == Data.mapType) { StepAside(targetEntity); }
				if (targetEntity.type == Data.playerType) { Fight(Data.player); }
				return this;
			}
			else
			{
				while (!targetEntity && FP.distance(x0, y0, x, y) < searchDistance && this.onCamera == true)
				{
					moveTowards(Data.player.x, Data.player.y, searchStep);
					targetEntity = Entity(collideTypes(targetTypes, x, y));
				}
				x = x0;
				y = y0;
				
				if (targetEntity) { return targetEntity; }
				else { return null; }
			}
		}
		
		public function StepAside(targetEntity:Entity):void
		{
			var destination:Point = new Point;
			var speed:Number;
			var angle:Number;
			
			if (targetEntity.type == Data.zombieType)
			{
				speed = Data.zombieSpeed * FP.elapsed;
				angle = FP.angle(x, y, targetEntity.x, targetEntity.y);
				
				FP.angleXY(destination, angle, -speed);
				
				moveAngle = angle + 180;
				x += destination.x;
				y += destination.y;
			}
			
			if (targetEntity.type == Data.mapType)
			{
				var distance:Number = halfWidth / 2 + width;
				speed = Data.zombieSpeed * FP.elapsed;
				angle = 0;
				
				var x0:Number = x;
				var y0:Number = y;
				
				var possibleDestinations:Array = new Array;
				
				if (possibleDestinations.length == 0)
				{
					while (angle < 360)
					{
						moveTo(x0, y0);
						FP.angleXY(destination, angle, distance);
						x += destination.x;
						y += destination.y;
						
						if (!collideTypes(Data.mapType, x, y)) { possibleDestinations.push(new Point(x, y)); }
						angle += 45;
					}
					moveTo(x0, y0);
				}
				if (possibleDestinations.length > 0)
				{
					var chosenPosition:uint = FP.rand(possibleDestinations.length);
					if (possibleDestinations[chosenPosition])
					{
						moveTowards(possibleDestinations[chosenPosition].x, possibleDestinations[chosenPosition].y, speed);
					}
				}
			}
		}
		
		public function Move():void
		{
			var targetEntity:Entity = LocateTarget();
			var destination:Point = new Point;
			var x0:Number = x;
			var y0:Number = y;
			//trace(targetEntity);
			
			if (targetEntity)
			{
				if (targetEntity.type == Data.playerType && Data.player.playerAlive == true)
				{
					moveAngle = FP.angle(x, y, Data.player.x, Data.player.y);
					FP.angleXY(destination, moveAngle, Data.zombieSpeed * FP.elapsed);
					x += destination.x;
					y += destination.y;
					
					playerLKL = new Point(targetEntity.x, targetEntity.y);
				}
				
				if (targetEntity.type == Data.zombieType && Data.player.playerAlive == true && FP.distance(x, y, Data.player.x, Data.player.y) > FP.distance(targetEntity.x, targetEntity.y, Data.player.x, Data.player.y)) { Mobbing(targetEntity); }
				//if (targetEntity.type == Data.mapType && FP.distance(x, y, playerLKL.x, playerLKL.y) > Data.player.halfWidth) { Navigate(); }
				//if (targetEntity.type == Data.mapType && FP.distance(x, y, playerLKL.x, playerLKL.y) < Data.player.halfWidth) { Roam(); }
				else { roamTimer = 0; }
			}
			
			if (x == x0 && y == y0 && Data.player.playerAlive == true)
			{
				panicCounter += FP.elapsed;
				Panic();
			}
			else { panicCounter = 0; }
		}
		
		public function Fight(target:Player):void
		{
			if (biteReady == true && target.batReady == false && target.playerAlive == true)
			{
				this.world.add(new FloatingText("NHACK!!!", Color.Red, target.x, target.y));
				target.FlashOverlay();
				
				target.playerHealth -= Data.biteDamage;
				Data.scoreKeeper.BreakCombo();
				
				if (target.playerHealth < 0) { target.playerHealth = 0; }
				target.batTimer = 0;
				
				Data.generalEmitter.generalEmitter.emit("bloodSplashP", x, y);
				
				biteReady = false;
			}
		}
		
		public function Navigate():void
		{
			var destination:Point = new Point;
			var speed:Number = Data.zombieSpeed * FP.elapsed;
			var distance:Number = halfWidth / 2 + width;
			var angle:Number = FP.angle(x, y, playerLKL.x, playerLKL.y);
			
			var x0:Number = x;
			var y0:Number = y;
			
			if (waypoints[0] != playerLKL)
			{
				waypoints[0] = playerLKL;
				
				var possibleDestinations:Array = new Array;
				
				while (FP.distance(x, y, playerLKL.x, playerLKL.y) > speed)
				{
					FP.angleXY(destination, angle, speed);
					x += destination.x;
					y += destination.y;
					
					if (collide(Data.mapType, x, y))
					{
						FP.angleXY(destination, angle + 90, distance);
						
						if (!collideTypes(Data.mapType, x + destination.x, y + destination.y)) { possibleDestinations.push(new Point(x + destination.x, y + destination.y)); }
						if (!collideTypes(Data.mapType, x - destination.x, y - destination.y)) { possibleDestinations.push(new Point(x - destination.x, y - destination.y)); }
						
						if (possibleDestinations.length == 2)
						{
							if (FP.rand(1) == 1) { waypoints.push(possibleDestinations[1]); }
							else { waypoints.push(possibleDestinations[0]); }
						}
						
						if (possibleDestinations.length == 1)
						{
							waypoints.push(possibleDestinations[0]);
						}
					}
				}
				x = x0;
				y = y0;
			}
			
			angle = FP.angle(x, y, waypoints[waypoints.length - 1].x, waypoints[waypoints.length - 1].y)
			FP.angleXY(destination, angle, speed);
			x += destination.x;
			y += destination.y;
			
			if (FP.distance(x, y, waypoints[waypoints.length - 1].x, waypoints[waypoints.length - 1].y) < 1) { waypoints.splice(waypoints.length - 1, 1); }
		}
		
		public function Mobbing(targetEntity:Entity):void
		{
			var targetZombie:Zombie = targetEntity as Zombie;
			
			var targetTypes:Array = new Array(Data.zombieType, Data.mapType);
			
			var destination:Point = new Point;
			var speed:Number = Data.zombieSpeed * FP.elapsed;
			var distance:Number = halfWidth / 2 + width;
			var angle:Number = targetZombie.moveAngle;
			
			var x0:Number = x;
			var y0:Number = y;
			
			var possibleDestinations:Array = new Array;
			
			for ( var tries:uint = 0; tries < 3; tries ++)
			{
				moveTo(targetZombie.x, targetZombie.y);
				FP.angleXY(destination, angle + 90, distance);
				x += destination.x;
				y += destination.y;
				
				if (!collideTypes(targetTypes, x, y)) { possibleDestinations.push( { position:new Point(x, y), proximity:FP.distance( x0, y0, x, y) }); }
				angle += 90;
			}
			x = x0;
			y = y0;
			
			possibleDestinations.sortOn("proximity", Array.NUMERIC);
			if (possibleDestinations.length > 0)
			{
				if (possibleDestinations[0].position)
				{
					moveAngle = FP.angle(x, y, possibleDestinations[0].position.x, possibleDestinations[0].position.y);
					FP.angleXY(destination, moveAngle, Data.zombieSpeed * FP.elapsed);
					x += destination.x;
					y += destination.y;
				}
			}
		}
		
		public function Pursue():void
		{
			var destination:Point = new Point;
			
			moveAngle = FP.angle(x, y, playerLKL.x, playerLKL.y);
			FP.angleXY(destination, moveAngle, width);
			
			FP.angleXY(destination, moveAngle, Data.zombieSpeed * FP.elapsed);
			x += destination.x;
			y += destination.y;
		}
		
		public function Roam():void
		{
			var targetTypes:Array = new Array(Data.zombieType, Data.mapType);
			
			roamTimer += FP.elapsed;
			if (roamTimer >= roamLimit)
			{
				roamLimit = 1 + Math.random() * 2;
				roamAngle = Math.random() * 360;
				roamTimer = 0;
			}
			
			var destination:Point = new Point;
			
			moveAngle = roamAngle;
			FP.angleXY(destination, moveAngle, Data.zombieSpeed * FP.elapsed);
			if (!collideTypes(targetTypes, x + destination.x, y + destination.y))
			{
				x += destination.x;
				y += destination.y;
			}
		}
		
		public function Panic():void
		{
			var panicLimit:Number = 1;
			
			if (panicCounter >= panicLimit)
			{
				var targetTypes:Array = new Array(Data.zombieType, Data.mapType);
				var destination:Point = new Point;
				var speed:Number = Data.zombieSpeed * FP.elapsed;
				var distance:Number = halfWidth;
				var angle:Number = 0;
				
				var x0:Number = x;
				var y0:Number = y;
				
				if (FP.rand(1) == 1) { var bias:int = 1; }
				else { bias = -1; }
				
				var possibleDestinations:Array = new Array;
				
				for ( var tries:uint = 0; tries < 8; tries ++)
				{
					FP.angleXY(destination, angle + 45 * bias, distance);
					x += destination.x;
					y += destination.y;
					
					if (!collideTypes(targetTypes, x, y)) { possibleDestinations.push( { position:new Point(x, y), proximity:FP.distance( x0, y0, x, y) }); }
					angle += 45;
				}
				x = x0;
				y = y0;
				
				possibleDestinations.sortOn("position", Array.NUMERIC);
				if (possibleDestinations.length > 0)
				{
					if (possibleDestinations[0].position)
					{
						moveAngle = FP.angle(x, y, possibleDestinations[0].position.x, possibleDestinations[0].position.y);
						FP.angleXY(destination, moveAngle, Data.zombieSpeed * FP.elapsed);
						x += destination.x;
						y += destination.y;
					}
				}
				panicCounter = 0;
			}
		}
		
		public function EnterStage():void
		{
			if (x < 0 || x > FP.screen.width || y < 0 || y > FP.screen.height)
			{
				var destination:Point = new Point;
				var angle:Number = FP.angle(x, y, Data.player.x, Data.player.y);
				FP.angleXY(destination, angle, Data.zombieSpeed);
				
				x += destination.x * FP.elapsed;
				y += destination.y * FP.elapsed;
				moveAngle = angle;
			}
		}
		
		public function Die():void
		{
			this.world.remove(this);
			Data.generalEmitter.generalEmitter.emit("bloodSplashZ", x - halfWidth, y - halfWidth);
			Data.scoreKeeper.AddScore();
			//Data.crowdController.zombieList[zombieIndex.toString()] = "null";
			delete Data.crowdController.zombieList[zombieIndex];
		}
		
		public function Spawn():void
		{
			var spawnPoint:Point = new Point;
			var spawnAngle:Number = FP.rand(360);
			
			FP.angleXY(spawnPoint, spawnAngle, FP.screen.height / 2 + width);
			
			while (collide(Data.zombieType, FP.screen.width / 2 + FP.camera.x + spawnPoint.x, FP.screen.height / 2 + FP.camera.y + spawnPoint.y))
			{
				spawnPoint = new Point;
				spawnAngle = FP.rand(360);
				
				FP.angleXY(spawnPoint, spawnAngle, FP.screen.height / 2 + width);
			}
			
			x = FP.screen.width / 2 + FP.camera.x + spawnPoint.x;
			y = FP.screen.height / 2 + FP.camera.y + spawnPoint.y;
		}
	}
}