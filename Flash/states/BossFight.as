package states
{
	import Game;
	import flash.events.Event;
	import flash.text.*;
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import fl.controls.Button;
	import flash.ui.Mouse;
	import objects.Background;	
	import objects.Title;
	import objects.Boss;
	import objects.Hero;
	import objects.Ball;
	import interfaces.IState;
	
	public class BossFight extends Sprite implements IState
	{
		private var game:Game;
		private var background:Background;
		private var hero:Hero;
		private var boss:Boss;
		private var bossLifes:int = 10;
		private var lifes:int = 3;
		private var ball:Ball;
		private var speedY:Number = 10;
		private var speedX:Number = 10;
		private var gameScoreField: TextField;
		private var lifesField:TextField;
		
		
		
		
		public function BossFight(game:Game)
		{
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(event:Event):void
		{
			background = new Background(2);
			addChild(background); 
			
			hero = new Hero();
			ball = new Ball();
			boss = new Boss();

			var myFormat:TextFormat = new TextFormat();
			
			myFormat.bold = true; 
			myFormat.color = 0xFFFFFF; 
			myFormat.font = "Segoe Print";    
			myFormat.size = 26;
			
			gameScoreField = new TextField();
			gameScoreField.text = String(Game.gameScore);
			gameScoreField.x = 154;
			gameScoreField.y = 13;
			gameScoreField.defaultTextFormat = myFormat;
			
			lifesField = new TextField();
			lifesField.text = String(lifes);
			lifesField.x = 810;
			lifesField.y = 13;
			lifesField.defaultTextFormat = myFormat;

			addChild(hero);
			addChild(ball);
			addChild(boss);
			addChild(gameScoreField);
			addChild(lifesField);

		}
		
		private function showGameScore():void {
				gameScoreField.text = String(Game.gameScore);
				lifesField.text = String(lifes);
			}
		
		//this is how the ball moves
		private function moveBall():void
			{
				ball.x -=  speedX;
				ball.y -=  speedY;
				
				if (ball.y < 100 - ball.width)
				{
					speedY *=  -1;
					//myChannel = wallSound.play();
				}
				else if (ball.y > 600 - ball.width)
				{
					speedY *=  -1;
					//myChannel = wallSound.play();
				}
				if (ball.x < 100 - ball.width)
				{
					//myChannel = wallSound.play();
					speedX *=  -1;
				}
				else if (ball.x > 900 - ball.width)
				{
					ball.y = Math.floor(Math.random() * 440);
					ball.x = 500;
					lifes--;
				}

				if (ball.hitTestObject(hero))
				{
					
					calcBallAngle();
				}

			}
		
		//this is for when the ball hits the hero it will get its angle to go back
		private function calcBallAngle():void
			{
				var ballPosition:Number =   hero.y - ball.y;
				var hitPercent: Number = (ballPosition / (hero.height - ball.width)) - .005;
				speedY = hitPercent * 5;
				speedX *=  -1;
			}
		
		//For mouse movement
		private function moveHero():void
			{

				
				if (hero.y >= 196)
				{
					hero.y = mouseY;

				}
				else if (hero.y <= 568)
				{
					hero.y = mouseY;
				}
				
				if(lifes == 0)
					onGameOver();
				
			}		
		
		//To handle the ball hitting the wall
		private function handleCollisionBoss():void
			{

					if (ball.hitTestObject(boss))
					{
						bossLifes--;
						speedX *=  -1;
						speedY *=  -1;
					}
					
					if(bossLifes == 0)
					onGameWon();


			}
			
		private function onGameOver():void
		{
			game.changeState(Game.GAME_OVER_STATE);
		}
		
		private function onGameWon():void
		{
			
			game.changeState(Game.GAME_WON_STATE);
		}
		
		
		public function update():void
		{
			background.update();
			moveHero();
			moveBall();
			handleCollisionBoss();
			showGameScore();
			
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