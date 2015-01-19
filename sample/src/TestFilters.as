package  
{
	import aze.motion.easing.Quadratic;
	import aze.motion.eaze;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	
	/**
	 * Filters tweening test
	 * @author Philippe / http://philippe.elsass.me
	 */
	public class TestFilters extends Sprite
	{
		
		public function TestFilters() 
		{
			for (var i:int = 0; i < stage.stageWidth / 100; i++) 
			{
				for (var j:int = 0; j < stage.stageHeight / 100; j++) 
				{
					createItem(i * 100, j * 100);
				}
			}
		}
		
		private function createItem(sx:int, sy:int):void
		{
			var sp:Sprite = new Sprite();
			sp.x = sx + 10;
			sp.y = sy + 10;
			sp.graphics.beginFill(Math.random() * 0xffffff);
			sp.graphics.drawRect(0, 0, 80, 80);
			addChild(sp);
			
			// apply filter
			eaze(sp).filter(BlurFilter, { blurX:4, blurY:4 } );
			
			sp.addEventListener(MouseEvent.ROLL_OVER, over);
			sp.addEventListener(MouseEvent.ROLL_OUT, out);
		}
		
		private function out(e:MouseEvent):void 
		{
			eaze(e.target)
				.easing(Quadratic.easeInOut)
				.to(1)
				.filter(GlowFilter, { blurX:0, blurY:0, color:0xff00ff }, true);
		}
		
		private function over(e:MouseEvent):void 
		{
			eaze(e.target)
				.to(0.5)
				.easing(Quadratic.easeInOut)
				.filter(GlowFilter, { blurX:20, blurY:20, color:0x00ccff, knockout:true, quality:2 });
		}		
	}

}