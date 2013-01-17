package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	
	public class Score extends Entity
	{
		public var scoreText:Text;
		
		public function Score():void
		{
			Text.size = 30;
			scoreText = new Text("000" + Data.score.toString());
			graphic = scoreText;
			
			x = 15 + FP.camera.x;
			y = 15 + FP.camera.y;
		}
		
		
		override public function render():void 
		{
			x = 15 + FP.camera.x;
			y = 15 + FP.camera.y;
			
			super.render();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Data.score < 10)
			{
				scoreText.text = "00000" + Data.score.toString();
			}
			if (Data.score >= 10 && Data.score < 100)
			{
				scoreText.text = "0000" + Data.score.toString();
			}
			if (Data.score >= 100 && Data.score < 1000)
			{
				scoreText.text = "000" + Data.score.toString();
			}
			if (Data.score >= 1000 && Data.score < 10000)
			{
				scoreText.text = "00" + Data.score.toString();
			}
			if (Data.score >= 10000 && Data.score < 100000)
			{
				scoreText.text = "0" + Data.score.toString();
			}
			if (Data.score >= 100000 && Data.score < 1000000)
			{
				scoreText.text = Data.score.toString();
			}
		}
	}
}