package  
{
	import assets.ColorMatrixSample;
	import aze.motion.eaze;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import flash.utils.setInterval;
	
	/**
	 * ColorMatrix tweening test
	 * @author Philippe / http://philippe.elsass.me
	 */
	public class TestColorMatrix extends Sprite
	{	
		private var view:ColorMatrixSample;
		
		public function TestColorMatrix() 
		{
			view = new ColorMatrixSample();
			addChild(view);
			
			view.sBrightness.addEventListener(Event.CHANGE, animate);
			view.sContrast.addEventListener(Event.CHANGE, animate);
			view.sSaturation.addEventListener(Event.CHANGE, animate);
			view.sHue.addEventListener(Event.CHANGE, animate);
			view.sColorize.addEventListener(Event.CHANGE, animate);
			
			eaze(view).to(0).colorMatrix( -1)
				.delay(1)
				.delay(0).colorMatrix();
		}
		
		private function animate(e:Event):void 
		{
			/*eaze(view.mcPict)
				.to(1)
				.filter(ColorMatrixFilter, { 
					brightness:view.sBrightness.value,
					contrast:view.sContrast.value,
					saturation:view.sSaturation.value,
					hue:view.sHue.value,
					tint:parseInt("0x" + view.txtRGB.text),
					colorize:view.sColorize.value
				});*/
			eaze(view.mcPict)
				.to(1)
				.colorMatrix(view.sBrightness.value, view.sContrast.value, view.sSaturation.value,
					view.sHue.value, parseInt("0x" + view.txtRGB.text), view.sColorize.value);
		}
		
	}

}