package states
{
	import Game;
	import states.Play;
	
	import interfaces.IState;
	import flash.text.*;
	import objects.Background;
	import objects.Title;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import fl.controls.Button;
	
	public class GameOver extends Sprite implements IState
	{
		private var game:Game;
		private var background:Background;
		private var gameScoreField: TextField;
	
		
		public function GameOver(game:Game)
		{
			
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			background = new Background(4);
			addChild(background);
			
			var myFormat:TextFormat = new TextFormat();
			
     		myFormat.bold = true; 
			myFormat.color = 0xFFFFFF; 
			myFormat.font = "Segoe Print";    
			myFormat.size = 30;
			
			gameScoreField = new TextField();
			gameScoreField.text = String(Game.gameScore);
			gameScoreField.x = 778;
			gameScoreField.y = 126;
			gameScoreField.defaultTextFormat = myFormat;
			
			addChild(gameScoreField);
 			
			var playButton:Button = new Button(); 
			addChild(playButton); 
			playButton.label = ""; 
			playButton.toggle =true; 
			playButton.width = 300;
			playButton.height = 50;
			playButton.move(531.95, 216);
			playButton.addEventListener(MouseEvent.CLICK, onPlay); 
			
			var menuButton:Button = new Button(); 
			addChild(menuButton); 
			menuButton.label = ""; 
			menuButton.toggle =true;
			menuButton.width = 522.95;
			menuButton.height = 50;
			menuButton.move(522.95, 356);
			menuButton.addEventListener(MouseEvent.CLICK, onMenu); 
		}
		
		private function showGameScore():void {
				this.gameScoreField.text = String(Game.gameScore);
				
			}
		private function onPlay(event:Event):void
		{
			removeEventListener(MouseEvent.CLICK, onMenu);
			removeEventListener(MouseEvent.CLICK, onPlay);
			game.changeState(Game.PLAY_STATE);
		}
		
		private function onMenu(event:Event):void
		{
			removeEventListener(MouseEvent.CLICK, onMenu);
			removeEventListener(MouseEvent.CLICK, onPlay);
			game.changeState(Game.MENU_STATE);
		}
			
		
		private function onAgain(event:Event):void
		{
		
			game.changeState(Game.PLAY_STATE);
		}
		
		public function update():void
		{
			background.update();
			showGameScore();
			
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