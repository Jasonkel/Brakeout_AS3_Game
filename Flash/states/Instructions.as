package states
{
	import Game;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import fl.controls.Button;
	import objects.Background;
	

	import interfaces.IState;
	
	public class Instructions extends Sprite implements IState
	{
		public var game:Game;
		private var background:Background;
		
		
		public function Instructions(game:Game)
		{
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			background = new Background(3);
			addChild(background);
			
			 			
			
			var playButton:Button = new Button(); 
			addChild(playButton); 
			playButton.label = ""; 
			playButton.toggle =true; 
			playButton.width = 400;
			playButton.height = 50;
			playButton.move(646.3, 542.65);
			playButton.addEventListener(MouseEvent.CLICK, onPlay); 
			
			
		}

		private function onPlay(event:Event):void
		{
			game.changeState(Game.PLAY_STATE);
		}
		
		private function onMenu(event:Event):void
		{
			game.changeState(Game.MENU_STATE);
		}
		
		public function update():void
		{
			background.update();
		}
		
		public function destroy():void
		{
			background.removeFromParent();
			background = null;
			removeFromParent();
		}
		
		private function removeFromParent()
		{
			var child:DisplayObject = this as DisplayObject;
			var parent:DisplayObjectContainer = child.parent;

			parent.removeChild(child);
		}
	}
}