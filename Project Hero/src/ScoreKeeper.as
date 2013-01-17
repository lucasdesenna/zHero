package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import flash.text.TextFormatAlign;
	import net.flashpunk.utils.Draw;
	
	public class ScoreKeeper extends Entity
	{
		private var score:uint
		private var oldScore:uint;
		
		private var comboCount:uint;
		private var comboTimer:Number;
		public var comboMultiplier:uint;
		
		private var allGraphics:Vector.<Graphic>;
		
		public function ScoreKeeper():void
		{
			score = 0;
			oldScore = score;
			comboMultiplier = 1;
			comboCount = 0;
			comboTimer = 1;
			
			SetGraphics();
		}
		
		public function SetGraphics():void
		{
			allGraphics = new Vector.<Graphic>;
			allGraphics.length = 2;
			
			//Score
			allGraphics[0] = new Text("");
			Text(allGraphics[0]).size = 20;
			//Text(allGraphics[0]).color = Color.Yellow;
			//Text(allGraphics[0]).alpha = 0.5;
			Text(allGraphics[0]).relative = false;
			Text(allGraphics[0]).x = FP.camera.x + 15;
			Text(allGraphics[0]).y = FP.camera.y + 10;
			
			//Combo
			allGraphics[1] = new Text("XX");
			Text(allGraphics[1]).size = 30;
			Text(allGraphics[1]).alpha = 0;
			//Text(allGraphics[1]).color = Color.Red;
			Text(allGraphics[1]).relative = false;
			//Text(allGraphics[1]).originX = -width;
			//Text(allGraphics[1]).originY = -height;
			Text(allGraphics[1]).x = FP.screen.width + FP.camera.x - Text(allGraphics[1]).width - 15;
			Text(allGraphics[1]).y = FP.camera.y + 8;
			
			//trace(allGraphics[0]);
			
			graphic = new Graphiclist(allGraphics[0], allGraphics[1]);
			
			layer = -2;
		}
		
		override public function render():void 
		{
/*			Text(allGraphics[0]).x = 15 + FP.camera.x;
			Text(allGraphics[0]).y = 15 + FP.camera.y;
			
			Text(allGraphics[1]).x = 250 + FP.camera.x;
			Text(allGraphics[1]).y = 15 + FP.camera.y;*/
			
			if (comboCount >= 5)
			{
				Draw.rectPlus(FP.screen.width + FP.camera.x - Text(allGraphics[1]).width - 15, 43 + FP.camera.y, Text(allGraphics[1]).width, 5, Color.DarkGray);
				Draw.rectPlus(FP.screen.width + FP.camera.x - Text(allGraphics[1]).width - 15, 43 + FP.camera.y, Text(allGraphics[1]).width * (comboTimer / 1), 5, Color.White);
			}
			
			super.render();
		}
		
		override public function update():void 
		{
			ManageScore();
			ManageCombo();
			
			super.update();
		}
		
		public function AddScore(baseScore:uint):void
		{
			score += baseScore;
		}
		
		public function BreakCombo():void
		{
			comboCount = 0;
			comboMultiplier = 1;
			Text(allGraphics[1]).text = "";
			Text(allGraphics[1]).alpha = 0;
		}
		
		private function ManageScore():void
		{
			if (score < 10)
			{
				Text(allGraphics[0]).text = "000000" + score.toString();
			}
			if (score >= 10 && score < 100)
			{
				Text(allGraphics[0]).text = "00000" + score.toString();
			}
			if (score >= 100 && score < 1000)
			{
				Text(allGraphics[0]).text = "0000" + score.toString();
			}
			if (score >= 1000 && score < 10000)
			{
				Text(allGraphics[0]).text = "000" + score.toString();
			}
			if (score >= 10000 && score < 100000)
			{
				Text(allGraphics[0]).text = "00" + score.toString();
			}
			if (score >= 100000 && score < 1000000)
			{
				Text(allGraphics[0]).text = "0" + score.toString();
			}
			if (score >= 1000000 && score < 10000000)
			{
				Text(allGraphics[0]).text = score.toString();
			}
		}
		
		private function ManageCombo():void
		{
			if (score != oldScore)
			{
				comboTimer = 1;
				comboCount ++;
				if (comboCount >= 5) { Text(allGraphics[1]).alpha = 1; }
			}
			
			if (score == oldScore && comboTimer > 0 && comboCount >= 5)
			{
				comboTimer -= FP.elapsed / 2;
				
				if (comboTimer < 0)
				{
					comboCount = 0;
					comboTimer = 0;
					Text(allGraphics[1]).alpha = 0;
					
					BreakCombo();
				}
			}
			
			if (comboCount >= 5)
			{
				for (var m:uint = 1; m < 50; m++)
				{
					if (comboCount >= 5 * m && comboCount <= 5 * (m + 1))
					{ 
						comboMultiplier = m * 5;
						
						break;
					}
				}
				
				Text(allGraphics[1]).text = "x" + comboMultiplier.toString();
				Text(allGraphics[1]).x = FP.screen.width + FP.camera.x - Text(allGraphics[1]).width - 15;
			}
			
			oldScore = score;
		}
	}
}