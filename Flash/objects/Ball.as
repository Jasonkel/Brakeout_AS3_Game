package objects  {
	
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	
	public class Ball extends Sprite {
		
		
		public function Ball() {
			
			this.x = 832;
			this.y = 373;
		}
		
		public function removeFromParent()
		{
			var child:DisplayObject = this as DisplayObject;
			var parent:DisplayObjectContainer = child.parent;
			parent.removeChild(child);
		}
		
		
	}
	
}