package  
{
	import aze.motion.eaze;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	
	/**
	 * Tweens chaining + scale property tween tests
	 * @author Philippe / http://philippe.elsass.me
	 */
	public class TestChain extends Sprite
	{
		private var _foo:Number = 0;
		
		public function TestChain() 
		{
			addEventListener(Event.ENTER_FRAME, tick);
			
			hello("before");
			
			// apply/delay/0 tween stability test
			eaze(this) 
				.onUpdate(updateHandler)
				.delay(0.1)
				.apply({ foo:1 })
				.to(0, { foo:2 })
				.delay(0)
				.to(0.1, { foo:3 })
				.delay(0)
				.apply({ foo:4 })
				.onComplete(hello, "after");
		}
		
		private function updateHandler():void
		{
			trace("update handler defined before tween");
		}
		
		private function tick(e:Event):void 
		{
			//trace("A frame has ticked");
		}
		
		private function hello(when:String):void
		{
			trace("Hello", when);
			if (when == "after") removeEventListener(Event.ENTER_FRAME, tick);
			else return;
			
			// chain 3 clips fade-ins
			var cpt:int = 0;
			var sp1:Sprite = createItem(cpt * 100, 10);
			sp1.name = "sp" + String(++cpt);
			var sp2:Sprite = createItem(cpt * 100, 10);
			sp2.name = "sp" + String(++cpt);
			var sp3:Sprite = createItem(cpt * 100, 10);
			sp3.name = "sp" + String(++cpt);
			
			eaze(sp1).onStart(startHandler)
				.delay(1)
				.from(1, { alpha:0 } ).updateNow()
				.onComplete(tweenComplete, sp1)
				.chain(sp2).from(1, { alpha:0 } ).updateNow()
				.onComplete(tweenComplete, sp2)
				.chain(sp3).from(1, { alpha:0 } ).updateNow()
				.onComplete(tweenComplete, sp3);
			
			// chain several tweens on one sprite, then blur stage
			var sp4:Sprite = createItem(0, 100);
			sp4.name = String(++cpt);
			eaze(sp4).delay(1)
				.from(1)
					.filter(BlurFilter, { blurX:20, blurY:20, quality:2 }, true)
					.updateNow()
				.to(1, { x:100, y:200, scale:0.5 } )
				.onComplete(tweenComplete, sp4)
				.to(1, { x:200, y:300, scale:1.5 } )
				.onComplete(tweenComplete, sp4)
				.to(1, { x:300, y:110, scale:1 } )
				.onComplete(endOfChain)
				.chain(this)
				.to("slow").filter(BlurFilter, { blurX:10, blurY:10, quality:2 } )
				.onComplete(tweenComplete, sp4);
			
			trace("tweens defined");
		}
		
		private function startHandler():void
		{
			trace("started");
		}
		
		private function endOfChain():void
		{
			trace("end of chain - blur all");
		}
		
		private function tweenComplete(sp:Sprite):void
		{
			trace("Tween complete", sp.name, sp.x, sp.y);
		}
		
		private function createItem(sx:int, sy:int):Sprite
		{
			var sp:Sprite = new Sprite();
			sp.x = sx + 10;
			sp.y = sy + 10;
			sp.graphics.beginFill(Math.random() * 0xffffff);
			sp.graphics.drawRect(0, 0, 80, 80);
			addChild(sp);
			return sp;
		}
		
		public function get foo():Number { return _foo; }
		
		public function set foo(value:Number):void 
		{
			_foo = value;
			trace("foo", value);
		}
		
		
	}

}