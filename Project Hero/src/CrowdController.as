package
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	public class CrowdController extends Entity
	{
		public const zombieList:Object = new Object;
		
		public function CrowdController():void
		{
			layer = 10;
		}
		
		override public function update():void 
		{
			super.update();
			ControlCrowd();
		}
		
		public function ControlCrowd():void
		{
			if (Data.player.world)
			{
				var positionList:Array = new Array;
				
				for ( var zombieName:String in zombieList)
				{
					var zombieDistance:Number = FP.distance(Data.player.x, Data.player.y, zombieList[zombieName].x, zombieList[zombieName].y); 
					var zombieY:Number = zombieList[zombieName].y; 
					positionList.push( { zName: zombieName, zDistance: zombieDistance, zY: zombieY } );
				}
				positionList.sortOn("zDistance", Array.NUMERIC);
				
				for ( var i:uint = 0; i < positionList.length; i++ )
				{
					if(zombieList[positionList[i].zName].graphic) { zombieList[positionList[i].zName].SuperRefresh(); }
				}
				
				positionList.sortOn("zY", Array.NUMERIC);
				
				for (i = 0; i < positionList.length; i++ )
				{
					var zEntity:Entity = zombieList[positionList[i].zName] as Entity;
					if (zEntity)
					{
						zEntity.world.bringToFront(zEntity);
					}
				}
			}
		}
	}
}