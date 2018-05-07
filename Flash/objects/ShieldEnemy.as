package objects {
	import states.Play;
	import objects.Health;
	import flash.display.MovieClip;



	public class ShieldEnemy extends MovieClip {

		private var localPlay: Play;
		private var health: int = 3;
		private var healthBar: Health;


		public function ShieldEnemy(localPlay: Play) {
			this.localPlay = localPlay;
			healthBar = new Health();
			healthBar.x = this.x - 5;
			healthBar.y = this.y + 40;
			addChild(healthBar);

		}

		public function die() {

			this.localPlay.arrayShield.splice(this.localPlay.arrayShield.indexOf(this), 1);
			parent.removeChild(this);

		}

		public function hit() {
			this.alpha -= 0.15;
			this.healthBar.width -= 10;
			health--;

		}

		public function healthReturn(): int {
			return health;
		}



	}
}