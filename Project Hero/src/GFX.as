package
{
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	
	public class GFX
	{
		//Player
		[Embed(source = 'assets/images/Sprites/Player.png')] public static const PLAYER:Class;
		[Embed(source='assets/images/Sprites/Char_Maks.png')] public static const MASK:Class;
		[Embed(source='assets/images/Overlays/HitOverlay.png')] public static const HIT_OVERLAY:Class;
		
		//Weapons
		[Embed(source = 'assets/images/Sprites/Baseball.png')] public static const BASEBALL:Class;
		[Embed(source = 'assets/images/Sprites/Handgun.png')] public static const HANDGUN:Class;
		[Embed(source = 'assets/images/Sprites/Shotgun.png')] public static const SHOTGUN:Class;
		[Embed(source = 'assets/images/Sprites/Sniper.png')] public static const SNIPER:Class;
		
		//Enemies
		[Embed(source = 'assets/images/Sprites/zNormal.png')] public static const ZNORMAL:Class;
		[Embed(source = 'assets/images/Sprites/zFamous.png')] public static const ZFAMOUS:Class;
		[Embed(source = 'assets/images/Sprites/zFan.png')] public static const ZFAN:Class;
		[Embed(source = 'assets/images/Sprites/zFurious.png')] public static const ZFURIOUS:Class;
		[Embed(source = 'assets/images/Sprites/zWimp.png')] public static const ZWIMP:Class;
		[Embed(source = 'assets/images/Sprites/Goo.png')] public static const GOO:Class;
		[Embed(source = 'assets/images/Sprites/zScary.png')] public static const ZSCARY:Class;
		
		//Effects
		[Embed(source='assets/images/Particles/BloodSplashP.png')] public static const BLOODSPLASHP:Class;
		[Embed(source = 'assets/images/Particles/BloodSplashZ.png')] public static const BLOODSPLASHZ:Class;
		[Embed(source = 'assets/images/Particles/Dust.png')] public static const DUST:Class;
		[Embed(source = 'assets/images/Particles/StunStar.png')] public static const STUNSTAR:Class;
		[Embed(source = 'assets/images/Particles/FamousSong.png')] public static const SONG:Class;
		[Embed(source = 'assets/images/Particles/PurpleCloud.png')] public static const PCLOUD:Class;
		[Embed(source = 'assets/images/Overlays/ScaryOverlay.png')] public static const SCARYOVERLAY:Class;
		
		//PowerUps
		public static const POWER_HANDGUN:Image = new Image(new BitmapData(4, 4, false, Color.Orange));
		public static const POWER_SHOTGUN:Image = new Image(new BitmapData(4, 4, false, Color.Pink));
		public static const POWER_SNIPER:Image = new Image(new BitmapData(4, 4, false, Color.Purple));
		public static const POWER_LASER:Image = new Image(new BitmapData(4, 4, false, Color.Brown));
		public static const POWER_GRENADE:Image = new Image(new BitmapData(4, 4, false, Color.Maroon));
		public static const POWER_MOLOTOV:Image = new Image(new BitmapData(4, 4, false, Color.Magenta));
		public static const POWER_FLAIL:Image = new Image(new BitmapData(4, 4, false, Color.Olive));
		public static const POWER_SLEDGEHAMMER:Image = new Image(new BitmapData(4, 4, false, Color.Violet));
		public static const POWER_KATANA:Image = new Image(new BitmapData(4, 4, false, Color.RoyalBlue));
		public static const POWER_AISTRIKE:Image = new Image(new BitmapData(4, 4, false, Color.Fuchsia));
		public static const POWER_ARMOR:Image = new Image(new BitmapData(4, 4, false, Color.Indigo));
		
		
		//Scenery
		[Embed(source='assets/levels/testLevel_GFX.png')] public static const SCENERY_GFX:Class
		[Embed(source = 'assets/levels/testLevel.png')] public static const SCENERY_MASK:Class;
	}
}