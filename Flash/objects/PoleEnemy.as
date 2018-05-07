package objects {
	
	
	import states.Play;
	import flash.display.Sprite;
	
	
	public class PoleEnemy extends Sprite {
		
		private var localPlay:Play;
		private var health:int = 2;
		private var healthBar:Health;
		
		public function PoleEnemy(localPlay:Play) {
			this.localPlay = localPlay;
			healthBar = new Health();
			healthBar.x = this.x-5;
			healthBar.y = this.y+40;
			addChild(healthBar);
		}
		
		public function die() {	
				
			this.localPlay.arrayPole.splice(this.localPlay.arrayPole.indexOf(this) ,1) ;
				parent.removeChild(this);
				
			}
		public function hit()
		{
			this.alpha -= 0.35;
			this.healthBar.width -= 20;
			health--;
		}
		
		public function healthReturn():int
		{
			return health;
		}
	}
	
}