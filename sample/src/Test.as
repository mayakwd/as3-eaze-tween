package  
{
	import aze.motion.easing.Elastic;
	import aze.motion.easing.Quart;
	import aze.motion.eaze;
	import aze.motion.EazeTween;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.hires.debug.Stats;
	
	[SWF(width = "800", height = "600", frameRate = "30", backgroundColor = "#FFFFFF")]
	
	/**
	 * Performance test
	 * @author Philippe / http://philippe.elsass.me
	 */
	public class Test extends Sprite
	{
		static private const N:int = 2000; // try 20000!
		static private const fade:ColorTransform = new ColorTransform (1, 1, 1, 1, -32, -16, -16);
		
		private var bmp:Bitmap;
		private var points:Vector.<Point>;
		private var cx:Number;
		private var cy:Number;
		private var toggle:Boolean;
		
		public function Test() 
		{
			EazeTween.defaultEasing = Quart.easeIn;
			
			var longtext:String = "";
			for (var j:int = 0; j < 50000; j++) 
			{
				longtext += "abcd ";
			}
			
			cx = stage.stageWidth / 2;
			cy = stage.stageHeight / 2;
			
			bmp = new Bitmap(new BitmapData(cx * 2, cy * 2, false, 0));
			addChild(bmp);
			
			points = new Vector.<Point>(N);
			for (var i:int = 0; i < N; i++) 
			{
				var p:Point = new Point();
				points[i] = p;
				var a:Number = Math.random() * Math.PI * 2;
				restart(p, cx + 1.5 * cx * Math.cos(a), cy + 1.5 * cy * Math.sin(a), 1.5 + Math.random() * 4.5);
			}
			
			addChild(new Stats());
			addEventListener(Event.ENTER_FRAME, paint);
			
			var txt:TextField = new TextField();
			txt.defaultTextFormat = new TextFormat("_sans", 10, 0xffffff);
			txt.autoSize = "left";
			txt.text = "Click to pause/resume tween engine";
			txt.y = stage.stageHeight - 20;
			addChild(txt);
			
			stage.addEventListener(MouseEvent.CLICK, toggleAnimation);
		}
		
		private function toggleAnimation(e:MouseEvent):void 
		{
			toggle = !toggle;
			if (toggle) EazeTween.pauseAllTweens();
			else EazeTween.resumeAllTweens();
		}
		
		private function paint(e:Event):void 
		{
			var bmpd:BitmapData = bmp.bitmapData;
			bmpd.lock();
			
			bmpd.colorTransform(bmpd.rect, fade);
			for (var i:int = 0; i < N; i++) 
			{
				var p:Point = points[i];
				bmpd.setPixel(p.x >> 0, p.y >> 0, 0xffffff);
			}
			bmpd.unlock();
		}
		
		private function restart(p:Point, dx:Number, dy:Number, t:Number):void
		{
			p.x = cx;
			p.y = cy;
			eaze(p).to(t, { x:dx, y:dy })
				.onComplete(restart, p, dx, dy, t);
		}
		
	}

}
