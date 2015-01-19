package  
{
	import assets.Cake;
	import aze.motion.eaze;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Philippe / http://philippe.elsass.me
	 */
	public class TestRect extends Sprite 
	{
		private var sp:Sprite;
		
		public function TestRect() 
		{
			sp = new Sprite();
			sp.addChild(new Bitmap(new Cake()));
			addChild(sp);
			
			var w:int = sp.width;
			var h:int = sp.height;
			
			eaze(sp).rect(new Rectangle(0, 0, w, h/2))
				.delay(0.5)
				.from(1).rect(new Rectangle(0, 0, w, 0))
				.to(1).rect(new Rectangle(0, h, w, 0))
				.to(1).rect(new Rectangle(0, 0, w, h))
				.to(1).rect(new Rectangle(w, 0, w, h));
		}
		
	}

}