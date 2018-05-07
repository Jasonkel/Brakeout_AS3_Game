package states {
	import Game;
	import flash.system.*;
	import flash.events.Event;
	import flash.text.*;
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import fl.controls.Button;
	import flash.ui.Mouse;
	import flash.media.SoundChannel;
	import objects.Background;
	import objects.Title;
	import objects.ShieldEnemy;
	import objects.PoleEnemy;
	import objects.SwordEnemy;
	import objects.Hero;
	import objects.Ball;
	import interfaces.IState;

	public class Play extends Sprite implements IState {
		private var game: Game;
		private var background: Background;
		private var hero: Hero;
		private var lifes: int = 3;
		private var enemys: int = 18;
		public var arrayPole: Array;
		public var arrayShield: Array;
		public var arraySword: Array;
		private var ball: Ball;
		private var speedY: Number = 10;
		private var speedX: Number = 10;
		private var gameScoreField: TextField;
		private var lifesField: TextField;
		var myKick: SoundChannel;
		var kick = new Kick();
		var scream = new Scream();





		public function Play(game: Game) {
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(event: Event): void {
			background = new Background(2);
			addChild(background);

			hero = new Hero();
			ball = new Ball();


			var myFormat: TextFormat = new TextFormat();

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
			addChild(gameScoreField);
			addChild(lifesField);


			setupEnemy();


		}
		private function showGameScore(): void {
			this.gameScoreField.text = String(Game.gameScore);
			this.lifesField.text = String(lifes);
		}


		//this is how the ball moves
		private function moveBall(): void {
			ball.x -= speedX;
			ball.y -= speedY;

			if (ball.y < 27.35 - ball.width) {
				speedY *= -1;

			} else if (ball.y > 614.95 - ball.width) {
				speedY *= -1;
				
			}
			if (ball.x < 25.95 - ball.width) {
				
				speedX *= -1;
			} else if (ball.x > 900 - ball.width) {
				ball.y = Math.floor(Math.random() * 440);
				ball.x = 300;
				lifes--;
			}

			if (ball.hitTestObject(hero)) {
				hero.punch();
				myKick = kick.play();
				calcBallAngle();
			}

			if (arrayShield.length == 0 && arrayPole.length == 0 && arraySword.length == 0) {
				onAllDead();
			}

			if (lifes == 0) {
				onGameOver();
			}


		}


		//this is for when the ball hits the hero it will get its angle to go back
		private function calcBallAngle(): void {
			var ballPosition: Number = hero.y - ball.y;
			var hitPercent: Number = (ballPosition / (hero.height - ball.width)) - .005;
			speedY = hitPercent * 5;
			speedX *= -1;
		}

		//For mouse movement
		private function moveHero(): void {

			
			if (hero.y >= 196) {
				hero.y = mouseY;

			} else if (hero.y <= 568) {
				hero.y = mouseY;
			}
		}


		private function handleCollisionSword(): void {

			for (var i: int = 0; i < arraySword.length; i++) {

				if (arraySword[i].hitTestObject(ball)) {
					arraySword[i].hit();
					arraySword[i].die();
					Game.gameScore += 1;
					speedX *= -1;
					speedY *= -1;
				}

			}



		}

		private function handleCollisionPole(): void {

			for (var i: int = 0; i < arrayPole.length; i++) {

				if (arrayPole[i].hitTestObject(ball)) {

					arrayPole[i].hit();

					if (arrayPole[i].healthReturn() == 0) {
						arrayPole[i].die();
						Game.gameScore += 2;
					}
					speedX *= -1;
					speedY *= -1;
				}
			}
		}

		private function handleCollisionShield(): void {
			for (var i: int = 0; i < arrayShield.length; i++) {
				if (arrayShield[i].hitTestObject(ball)) {

					arrayShield[i].hit();

					if (arrayShield[i].healthReturn() == 0) {
						myKick = scream.play();
						arrayShield[i].die();
						Game.gameScore += 3;

					}

					speedX *= -1;
					speedY *= -1;
				}
			}


		}


		//Array to Fill the pole wall
		private function setupEnemy(): void {
			arraySword = new Array();
			arrayPole = new Array();
			arrayShield = new Array();

			for (var i: uint = 0; i < 1; i++) {

				for (var j: int = 0; j < 6; j++) {

					var poleTemp: PoleEnemy = new PoleEnemy(this);
					poleTemp.y = 115 + (j * 80);
					poleTemp.x = 200;
					arrayPole.push(poleTemp);
					this.addChild(poleTemp);

					var swordTemp: SwordEnemy = new SwordEnemy(this);
					swordTemp.y = 115 + (j * 80);
					swordTemp.x = 120;
					arraySword.push(swordTemp);
					this.addChild(swordTemp);

					var shieldTemp: ShieldEnemy = new ShieldEnemy(this);
					shieldTemp.y = 115 + (j * 80);
					shieldTemp.x = 280;
					arrayShield.push(shieldTemp);
					this.addChild(shieldTemp);
				}

			}
		}


		private function onGameOver(): void {

			game.changeState(Game.GAME_OVER_STATE);

		}

		private function onAllDead(): void {
			game.changeState(Game.BOSS_FIGHT_STATE);
		}


		public function update(): void {
			background.update();
			moveHero();
			moveBall();
			handleCollisionSword();
			handleCollisionPole();
			handleCollisionShield();
			showGameScore();
		}

		public function destroy(): void {

			background.removeFromParent();
			background = null;
			hero.removeFromParent();
			ball.removeFromParent();
			removeFromParent();

		}

		private function removeFromParent(): void {
			var child: DisplayObject = this as DisplayObject;
			var parent: DisplayObjectContainer = child.parent;
			parent.removeChild(child);
		}
	}
}