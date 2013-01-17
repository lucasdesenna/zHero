package
{
	import net.flashpunk.Entity;
	
	public class zNormal extends Zombie
	{
		public function zNormal():void
		{
			dropRate = 0;
			
			SetGraphics(GFX.ZNORMAL, GFX.MASK);
		}
		
	}
}