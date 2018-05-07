package  objects{
	
	import flash.display.Sprite;
	import states.Play;
	
	
	public class SwordEnemy extends Sprite {
		
		private var localPlay:Play;
		private var healthBar:Health;
		
		public function SwordEnemy(chiBall:Play) {
			this.localPlay = chiBall;
			healthBar = new Health();
			healthBar.x = this.x-5;
			healthBar.y = this.y+40;
			addChild(healthBar);
		}
		
		public function die() {	
				
			this.localPlay.arraySword.splice(this.localPlay.arraySword.indexOf(this) ,1) ;
				parent.removeChild(this);
				
			}
			
	    public function hit()
		{
			this.healthBar.width -= 10;
			
		}
	}
	
}
