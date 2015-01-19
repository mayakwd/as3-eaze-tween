package  
{
	import aze.motion.eaze;
	import flash.display.Sprite;
	
	/**
	 * Scale tweening 
	 * + check target properties take precedence over special properties
	 * @author Philippe / http://philippe.elsass.me
	 */
	public class TestScale extends Sprite
	{
		private var sp1:Sprite;
		private var sp2:SpecialTarget;
		
		public function TestScale() 
		{
			sp1 = new Sprite();
			sp1.graphics.beginFill(0xffcc00);
			sp1.graphics.drawRect(0, 0, 100, 100);
			sp1.graphics.endFill();
			sp1.x = sp1.y = 10;
			addChild(sp1);
			
			sp2 = new SpecialTarget();
			sp2.y = 10;
			sp2.x = 220;
			sp2.graphics.beginFill(0xff9900);
			sp2.graphics.drawRect(0, 0, 100, 100);
			sp2.graphics.endFill();
			addChild(sp2);
			
			eaze(sp1).to(3, { scale:2 } );
			eaze(sp2).to(3, { scale:2 } )
				.onComplete(control);
		}
		
		private function control():void
		{
			trace("sp1", sp1.scaleX, sp1.scaleY);
			trace("sp2", sp2.scaleX, sp2.scaleY, sp2.scale);
		}
		
	}

}

import flash.display.Sprite;

class SpecialTarget extends Sprite
{
	private var _scale:Number = 0;
	
	public function get scale():Number { return _scale; }
	
	public function set scale(value:Number):void 
	{
		_scale = value;
		scaleX = scaleY = 1 - scale / 4;
	}
}