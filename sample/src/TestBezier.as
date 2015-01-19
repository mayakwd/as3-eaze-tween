package  
{
	import aze.motion.easing.Linear;
	import aze.motion.eaze;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Bezier (simple & through) test
	 * @author Philippe / http://philippe.elsass.me
	 */
	public class TestBezier extends Sprite
	{
		private var p0:Shape;
		private var p1:Shape;
		private var p2:Shape;
		private var p3:Shape;
		private var pt:Shape;
		private var through:Boolean = false; // change bezier mode here
		private var info:TextField;
		
		public function TestBezier() 
		{
			p0 = createShape(0xFFE6C4);
			p1 = createShape(0xFFCA82);
			p2 = createShape(0xFFA953);
			p3 = createShape(0xff9900);
			
			pt = createShape(0xFFE6C4);
			
			info = new TextField();
			info.defaultTextFormat = new TextFormat("_sans", 10, 0x999999);
			info.autoSize = "left";
			addChild(info);
			updateInfo();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(MouseEvent.CLICK, stage_click);
		}
		
		private function updateInfo():void
		{
			info.text = through ? "Bezier through" : "Simple Bezier";
			info.appendText("\n(press Space to toggle - click somewhere to animate)");
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.charCode == 32)
			{
				through = !through;
				updateInfo();
			}
		}
		
		private function createShape(color:uint):Shape
		{
			var sp:Shape = new Shape();
			sp.graphics.lineStyle(2, 0xff9900);
			sp.graphics.beginFill(color);
			sp.graphics.drawCircle(0, 0, 6);
			sp.graphics.endFill();
			sp.x = stage.stageWidth / 2;
			sp.y = stage.stageHeight / 2;
			addChild(sp);
			return sp;
		}
		
		private function stage_click(e:MouseEvent):void 
		{
			p0.x = pt.x;
			p0.y = pt.y;
			randomPos(p1);
			randomPos(p2);
			p3.x = mouseX;
			p3.y = mouseY;
			
			graphics.clear();
			graphics.moveTo(pt.x, pt.y);
			graphics.lineStyle(2, 0xdddddd);
			
			eaze(pt).apply( { tint:null } );
			
			if (through)
			{
				// double array for "bezier through" mode
				eaze(pt).to(2, { 
						x:[[p1.x, p2.x, p3.x]],
						y:[[p1.y, p2.y, p3.y]],
						alpha:[[0.2,0.8,1]],
						scale:[[2,0.5,1]],
						tint:0xff9900
					})
					.easing(Linear.easeNone)
					.onUpdate(draw);
			}
			else 
			{
				eaze(pt).to(2, { 
						x:[p1.x, p2.x, p3.x],
						y:[p1.y, p2.y, p3.y],
						alpha:[0.2,0.8,1],
						scale:[2,0.5,1],
						tint:0xff9900
					})
					.easing(Linear.easeNone)
					.onUpdate(draw);
			}
		}
		
		private function draw():void
		{
			graphics.lineTo(pt.x, pt.y);
		}
		
		private function randomPos(sp:Shape):void
		{
			sp.x = 40 + (stage.stageWidth - 80) * Math.random();
			sp.y = 40 + (stage.stageHeight - 80) * Math.random();
		}
		
	}

}