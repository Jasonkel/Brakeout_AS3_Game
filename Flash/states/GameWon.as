package states
{
	import Game;
	
	import interfaces.IState;
	
	import objects.Background;
	import objects.Title;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import fl.controls.Button;
	
	public class GameWon extends Sprite implements IState
	{
		private var game:Game;
		private var background:Background;
	
		
		public function GameWon(game:Game)
		{
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			background = new Background(5);
			addChild(background);
 			
			var instructionsButton:Button = new Button(); 
			addChild(instructionsButton); 
			instructionsButton.label = ""; 
			instructionsButton.toggle =true; 
			instructionsButton.width = 400;
			instructionsButton.height = 50;
			instructionsButton.move(550.85, 538.35);
			instructionsButton.addEventListener(MouseEvent.CLICK, onInstructions);
		}

		private function onInstructions(event:Event):void
		{
			game.changeState(Game.MENU_STATE);
		}
			
		
		public function update():void
		{
			background.update();
		}
		
		public function destroy():void
		{
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