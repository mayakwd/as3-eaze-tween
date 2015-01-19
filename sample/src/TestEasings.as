package  
{
	import aze.motion.easing.Back;
	import aze.motion.easing.Bounce;
	import aze.motion.easing.Cubic;
	import aze.motion.easing.Elastic;
	import aze.motion.easing.Expo;
	import aze.motion.easing.Quadratic;
	import aze.motion.easing.Quint;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Easing equations control
	 * @author Philippe / http://philippe.elsass.me
	 */
	public class TestEasings extends Sprite
	{
		private const STEPS:int = 40;
		private var cy:int = 5;
		private var cx:int = 10;
		
		public function TestEasings() 
		{
			test("Quadratic.easeIn", Quadratic.easeIn);
			test("Quadratic.easeOut", Quadratic.easeOut);
			test("Quadratic.easeInOut", Quadratic.easeInOut);
			newLine();
			test("Cubic.easeIn", Cubic.easeIn);
			test("Cubic.easeOut", Cubic.easeOut);
			test("Cubic.easeInOut", Cubic.easeInOut);
			newLine();
			test("Quint.easeIn", Quint.easeIn);
			test("Quint.easeOut", Quint.easeOut);
			test("Quint.easeInOut", Quint.easeInOut);
			newLine();
			test("Expo.easeIn", Expo.easeIn);
			test("Expo.easeOut", Expo.easeOut);
			test("Expo.easeInOut", Expo.easeInOut);
			newLine();
			test("Elastic.easeIn", Elastic.easeIn);
			test("Elastic.easeOut", Elastic.easeOut);
			test("Elastic.easeInOut", Elastic.easeInOut);
			newLine();
			test("Back.easeIn", Back.easeIn);
			test("Back.easeOut", Back.easeOut);
			test("Back.easeInOut", Back.easeInOut);
			newLine();
			test("Bounce.easeIn", Bounce.easeIn);
			test("Bounce.easeOut", Bounce.easeOut);
			test("Bounce.easeInOut", Bounce.easeInOut);
		}
		
		private function newLine():void
		{
			cx = 10;
			cy += 70;
		}
		
		private function test(name:String, easing:Function):void
		{
			var t:TextField = new TextField();
			t.defaultTextFormat = new TextFormat("_sans", 10, 0xffffff);
			t.text = name;
			t.x = cx;
			t.y = cy;
			addChild(t);
			
			graphics.lineStyle(1, 0x999999);
			graphics.drawRect(cx, cy + 15, 200, 50);
			graphics.moveTo(cx, cy + 65);
			graphics.lineStyle(1, 0xff9933);
			for (var i:int = 0; i <= STEPS; i++) 
			{
				graphics.lineTo(cx + 200 * i / STEPS, cy + 60 - easing(i / STEPS) * 45);
			}
			cx += 250;
		}
		
	}

}
