package  
{
	import aze.motion.easing.Back;
	import aze.motion.eaze;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * Test short rotation tweening (click to rotate arrow)
	 * @author Philippe / http://philippe.elsass.me
	 */
	public class TestShortRotation extends Sprite
	{
		private var arrow:Shape;
		
		public function TestShortRotation() 
		{	
			arrow = createArrow();			
			arrow.x = stage.stageWidth / 2;
			arrow.y = stage.stageHeight / 2;
			addChild(arrow);
			
			stage.addEventListener(MouseEvent.CLICK, click);
		}
		
		private function click(e:MouseEvent):void 
		{
			var a:Number = Math.atan2(mouseY - arrow.y, mouseX - arrow.x) * 180 / Math.PI;
			eaze(arrow).to("slow")
				.short("rotation", a)
				.easing(Back.easeInOut);
		}
		
		private function createArrow():Shape
		{
			var sp:Shape = new Shape();
			sp.graphics.lineStyle(2, 0xff6600);
			sp.graphics.beginFill(0xffcc99);
			sp.graphics.drawCircle(0, 0, 10);
			sp.graphics.beginFill(0xffcc99);
			sp.graphics.moveTo(1, -10);
			sp.graphics.lineTo(50, 0);
			sp.graphics.lineTo(1, 10);
			sp.graphics.lineStyle();
			sp.graphics.endFill();
			return sp;
		}
		
	}

}