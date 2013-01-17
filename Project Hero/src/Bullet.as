package
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import flash.display.BitmapData;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.World;
	
	public class Bullet extends Entity
	{
		private var bulletImage:Image;
		private var fireAngle:Number;
		private var dispersion:Number;
		private var sourceX:int;
		private var sourceY:int;
		
		public var weaponDISPERSIONMIN:Number;
		
		private var deviation:int;
		private var rndm:Number;
		private var velocity:Point;
		private var collided:Boolean;
		
		private var oldX:int;
		private var oldY:int;
		private var finalX:int;
		private var finalY:int;
				
		public function Bullet(SOURCE_X:int, SOURCE_Y:int, FIREANGLE:Number):void
		{
			bulletImage = new Image( new BitmapData(1, 1, true));
			fireAngle = FIREANGLE;
			sourceX = SOURCE_X;
			sourceY = SOURCE_Y;
			
			type = Data.bulletType;
			collidable = true;
			
			mask = new Pixelmask(new BitmapData(1, 1, true));
			
			velocity = new Point;
			
			FP.angleXY(velocity, fireAngle); 
			x = sourceX;
			y = sourceY;
		}
		
		override public function added():void
		{
			while(!collide(Data.zombieType, x, y) && x > 0 && x < FP.screen.width && y > 0 && y < FP.screen.height)
			{
				x += velocity.x;
				y += velocity.y;
			}
			
			finalX = x;
			finalY = y;
			//trace(finalX);
			
			x = sourceX;
			y = sourceY;
		}
		
		override public function update():void
		{
			Move();
			CollisionCheck();
			Trace();
		}
		
		public function Move():void
		{
			oldX = x;
			oldY = y;
			
			x += velocity.x * Data.bulletSpeed * FP.elapsed;
			y += velocity.y * Data.bulletSpeed * FP.elapsed;
		}
		
		public function Trace():void
		{
			this.world.add(new Tracer(oldX, oldY, x, y, 0.2));
		}
		
		public function Destroy():void
		{
			if (this.world)
			{
				this.world.remove(this);
			}
		}
		
		public function CollisionCheck():void
		{
			if (FP.distance(oldX, oldY, finalX, finalY) <= Data.bulletSpeed * FP.elapsed)
			{
				x = finalX + velocity.x * 16;
				y = finalY + velocity.y * 16;
				
				Destroy();
			}
		}
	}
}