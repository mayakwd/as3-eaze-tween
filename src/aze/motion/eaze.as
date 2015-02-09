/*
	Eaze is an Actionscript 3 tween library by Philippe Elsass
	Contact: philippe.elsass*gmail.com
	Website: http://code.google.com/p/eaze-tween/
	License: http://www.opensource.org/licenses/mit-license.php
 */
package aze.motion {
	import aze.motion.specials.PropertyBezier;
	import aze.motion.specials.PropertyColorMatrix;
	import aze.motion.specials.PropertyFilter;
	import aze.motion.specials.PropertyFrame;
	import aze.motion.specials.PropertyRect;
	import aze.motion.specials.PropertyShortRotation;
	import aze.motion.specials.PropertyTint;
	import aze.motion.specials.PropertyVolume;
	/**
	 * Select a target for tweening. Target can be single object or Array/Vector. 
	 */
	public function eaze(target : *) : EazeTween {
		return new EazeTween(target);
	}
	
	{
		PropertyTint.register();
		PropertyFrame.register();
		PropertyFilter.register();
		PropertyVolume.register();
		PropertyColorMatrix.register();
		PropertyBezier.register();
		PropertyShortRotation.register();
		PropertyRect.register();
	}
}
