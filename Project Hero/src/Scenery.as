package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask
	
	public class Scenery extends Entity
	{
		public function Scenery():void
		{
			type = Data.mapType;
			
			mask = new Pixelmask(GFX.SCENERY_MASK);
			graphic = new Image(GFX.SCENERY_GFX);
			Data.sceneryWidth = Image (graphic).width;
			Data.sceneryHeight = Image(graphic).height;
			
			layer = 10;
		}
	}
}