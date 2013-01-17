package
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	public class Data
	{
		//types
		public static const playerType:String = "player";
		public static const zombieType:String = "zombie";
		public static const mapType:String = "map";
		public static const gooType:String = "goo";
		public static const powerType:String = "powerUp";
		public static const bulletType:String = "bullet"
		
		//Player
		public static var player:Player;
		
		public static const playerSpeed:uint = 120;
		
		public static const playerMaxHealth:Number = 100;
		public static const playerRegenRate:Number = 50;
		
		public static const batRechargeT:Number = 0.2;
		
		public static const stunLimitT:Number = 2;
		
		//Zombie
		
		public static const zombieScreenL:int = 40;
		public static const zombieSpeed:uint = 40;
		public static var zombieCount:uint = 0;
		public static const zombieMaxCount:uint = 20;
		
		public static const biteRechargeT:Number = 1;
		public static const biteDamage:Number = 10; //5
		public static const gooMaxLifeT:Number = 5;
		public static const gooDamage:Number = 40;
		
		public static const zFamousAttackDist:Number = 100;
		
		//Scenery
		public static var sceneryWidth:uint = 320;
		public static var sceneryHeight:uint = 480;
		
		//FloatingText
		public static const floatingextSpeed:uint = 30;
		
		//Emitter
		public static const lowEmitter:GeneralEmitter = new GeneralEmitter(2);
		public static const highEmitter:GeneralEmitter = new GeneralEmitter(-2);
		
		//Score
		public static const scoreKeeper:ScoreKeeper = new ScoreKeeper;
		
		//CrowdController
		public static const crowdController:CrowdController = new CrowdController;
		
		//WaveController
		public static const waveController:WaveController = new WaveController;
		
		//weapons
		public static const bulletSpeed:int = 3000;
	}
}