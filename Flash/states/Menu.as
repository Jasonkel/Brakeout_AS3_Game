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
	import flash.media.SoundChannel;
	import flash.events.TouchEvent;
	
	
	public class Menu extends Sprite implements IState
	{
		private var game:Game;
		private var background:Background;
	    public static var  myChannel:SoundChannel;
		var backMusic = new export();
		
		
		public function Menu(game:Game)
		{
			if(myChannel != null){
			myChannel.stop();
			trace("gogo");
			}
			trace("nono");
			
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			background = new Background(1);
			addChild(background);
			
			
			
			myChannel = backMusic.play(0, int.MAX_VALUE);
			
			
			var playButton:Button = new Button(); 
			addChild(playButton); 
			playButton.toggle =true;
			playButton.label = "";
			playButton.width = 300;
			playButton.height = 50;
			playButton.move(500, 180);
			playButton.addEventListener(MouseEvent.CLICK, onPlay); 
			
			var instructionsButton:Button = new Button(); 
			addChild(instructionsButton); 
			instructionsButton.label = ""; 
			instructionsButton.toggle =true; 
			instructionsButton.width = 400;
			instructionsButton.height = 50;
			instructionsButton.move(460, 370);
			instructionsButton.addEventListener(MouseEvent.CLICK, onInstructions); 
	
			
			
	
		}
		
		private function onPlay(event:Event):void
		{
			game.changeState(Game.PLAY_STATE);
		}
		
		private function onInstructions(event:Event):void
		{
			game.changeState(Game.INSTRUCTIONS_STATE);
		}
		
		public function update():void
		{
			background.update();
		}
		
		public function destroy():void
		{
			background.removeFromParent();
			background = null;
			if (numChildren > 0) 
				{ 
				removeChildAt(0); 
				}
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