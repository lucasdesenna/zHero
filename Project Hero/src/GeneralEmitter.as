package
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Ease;


	public class GeneralEmitter extends Entity
	{
		public var generalEmitter:Emitter;
		
		public function GeneralEmitter(_layer:int):void
		{			
			layer = _layer;
			graphic = new Graphiclist;
			
			generalEmitter = new Emitter(new BitmapData(2, 2, false, Color.Red), 2, 2);
			
			SetStatusEffects();
			
			SetAttackEffects();
			
			graphic = generalEmitter;
		}
		
		public function SetStatusEffects():void
		{
			//Bleed
			generalEmitter.newType("bloodTrail", [0]);
			generalEmitter.setAlpha("bloodTrail", 1, 0, Ease.quadOut);
			generalEmitter.setMotion("bloodTrail", 0, 0, 7, 0, 0, 3);
			
			generalEmitter.setSource(GFX.BLOODSPLASHP, 32, 32);
			generalEmitter.newType("bloodSplashP", [0]);
			generalEmitter.setAlpha("bloodSplashP", 1, 0, Ease.quadOut);
			generalEmitter.setMotion("bloodSplashP", 0, 0, 7, 0, 0, 3);
			
			generalEmitter.setSource(GFX.BLOODSPLASHZ, 32, 32);
			generalEmitter.newType("bloodSplashZ", [0]);
			generalEmitter.setAlpha("bloodSplashZ", 1, 0, Ease.quadOut);
			generalEmitter.setMotion("bloodSplashZ", 0, 0, 7, 0, 0, 3);
			
			//Stunned
			generalEmitter.setSource(GFX.STUNSTAR, 16, 16);
			
			var frameArray:Array = new Array;
			for (var f:uint = 0; f < 8; f++)
			{
				frameArray.push(f);
			}
			//trace(frameArray);
			generalEmitter.newType("stunStar", frameArray);
			//generalEmitter.setAlpha("stunStar", 1, 0, Ease.quadOut);
			generalEmitter.setMotion("stunStar", 90, 30, 2, 0, 0, 0);
		}
		
		public function SetAttackEffects():void
		{
			generalEmitter.setSource(GFX.DUST, 8, 8);
			generalEmitter.newType("dust", [0]);
			generalEmitter.setColor("dust", Color.Red, Color.Yellow, Ease.quadOut);
			generalEmitter.setAlpha("dust", 1, 0, Ease.quadOut);
			generalEmitter.setMotion("dust", 75, 20, 0.5, 30, 5, 0.5);
			
			generalEmitter.setSource(GFX.SONG, 16, 16);
			generalEmitter.newType("song", [0]);
			generalEmitter.setAlpha("song", 1, 0, Ease.quadOut);
			generalEmitter.setMotion("song", 90, 20, 1, 0, 20, 1);
			
			generalEmitter.setSource(GFX.PCLOUD, 8, 8);
			generalEmitter.newType("pCloud", [0]);
			generalEmitter.setAlpha("pCloud", 1, 0, Ease.quadOut);
			generalEmitter.setMotion("pCloud", 80, 20, 1, 20, 20, 1);
		}
	}
}