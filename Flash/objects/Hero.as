package objects {
	
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	
	public class Hero extends MovieClip {
		
		
		public function Hero() {
			this.x = 832;
			this.y = 373;
		}
		
		
		public function punch()
		{
			this.gotoAndPlay(2);
		}
		
		public function removeFromParent()
		{
			var child:DisplayObject = this as DisplayObject;
			var parent:DisplayObjectContainer = child.parent;
			parent.removeChild(child);
		}
	}
	
}
