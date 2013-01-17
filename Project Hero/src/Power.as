package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	public class Power extends Entity
	{
		public var power:String;
		
		public function Power(_x:int, _y:int):void
		{
			x = _x;
			y = _y;
			
			SetPower();
			
			type = Data.powerType;
			//setHitbox(Image(graphic).width, Image(graphic).height);
			setHitbox(2, 2);
			
			layer = 2;
		}
		
		private function SetPower():void
		{
			var p:uint = FP.rand(11);
			
			if ( p == 0)
			{ 
				power = "handgun";
				graphic = GFX.POWER_HANDGUN;
			}
			if ( p == 1)
			{ 
				power = "shotgun";
				graphic = GFX.POWER_SHOTGUN;
			}
			if ( p == 2)
			{ 
				power = "sniper";
				graphic = GFX.POWER_SNIPER;
			}
			if ( p == 3)
			{ 
				power = "laser";
				graphic = GFX.POWER_LASER;
			}
			if ( p == 4)
			{ 
				power = "grenade";
				graphic = GFX.POWER_GRENADE;
			}
			if ( p == 5)
			{ 
				power = "molotov";
				graphic = GFX.POWER_MOLOTOV;
			}
			if ( p == 6)
			{ 
				power = "flail";
				graphic = GFX.POWER_FLAIL;
			}
			if ( p == 7)
			{ 
				power = "sledgehammer";
				graphic = GFX.POWER_SLEDGEHAMMER;
			}
			if ( p == 8)
			{ 
				power = "katana";
				graphic = GFX.POWER_KATANA;
			}
			if ( p == 9)
			{ 
				power = "airstrike";
				graphic = GFX.POWER_AISTRIKE;
			}
			if ( p == 10)
			{ 
				power = "armor";
				graphic = GFX.POWER_ARMOR;
			}
		}
	}
}