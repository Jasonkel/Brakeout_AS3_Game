package objects
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Title extends Sprite
	{
		private var titleText:TextField;
		
		public function Title()
		{
			
			var myFormat:TextFormat = new TextFormat();
			
			myFormat.bold = false; 
			myFormat.color = 0xff0000; 
			myFormat.font = "TradeGothic";    
			myFormat.size = 16;
			
			titleText = new TextField();
			titleText.defaultTextFormat = myFormat;
			addChild(titleText);
			

			
			
			
		}
		
		public function setTitle(title:String):void
		{
			titleText.text = title;
		}
	}
}