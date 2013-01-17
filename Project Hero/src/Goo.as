package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.FP;
	
	public class Goo extends Entity
	{
		private var gooLifeT:Number = 0;
		
		public function Goo(_x:int, _y:int):void
		{
			graphic = new Image(GFX.GOO);
			Image(graphic).centerOO();
			
			setHitbox(16, 16, 8, 8);
			//mask = new Pixelmask(GFX.MASK, Image(graphic).width / 2, Image(graphic).height / 2);
			
			x = _x;
			y = _y;
			
			type = Data.gooType;
			layer = 1;
			
			collidable = false;
		}
		
		override public function update():void 
		{
			gooLifeT += FP.elapsed;
			if (gooLifeT >= 0.5) { collidable = true; }
			Image(graphic).alpha -= FP.elapsed / Data.gooMaxLifeT;
			
			if (gooLifeT >= Data.gooMaxLifeT) { this.world.remove(this); }
			super.update();
		}
	}
}