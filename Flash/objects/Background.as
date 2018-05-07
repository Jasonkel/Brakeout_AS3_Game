package objects
{
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	
	
	public class Background extends Sprite
	{
		private var sky1:Sky1;
		private var sky2:Sky2;
		private var sky3:Sky3;
		private var sky4:Sky4;
		private var sky5:Sky5;
		var back:int;
		
		
		
		public function Background(back)
		{
			
			switch(back){
			case 1:
			sky1 = new Sky1();
			addChild(sky1);
			break;
			
			case 2:
			sky2 = new Sky2();
			addChild(sky2);
			break;
			
			case 3:
			sky3 = new Sky3();
			addChild(sky3);
			break;
			
			case 4:
			sky4 = new Sky4();
			addChild(sky4);
			break;
			
			case 5:
			sky5 = new Sky5();
			addChild(sky5);
			break;
			}
			
						
		}
		
		
		public function update():void
		{
		}
		
		public function removeFromParent()
		{
			var child:DisplayObject = this as DisplayObject;
			var parent:DisplayObjectContainer = child.parent;
			parent.removeChild(child);
		}
	}
}