package aze.motion.specials {
	import aze.motion.EazeTween;
	import aze.motion.specials.EazeSpecial;

	/**
	 * Numeric tweening along a Bezier curve
	 * @author Philippe / http://philippe.elsass.me
	 */
	public class PropertyBezier extends EazeSpecial {
		static public function register() : void {
			EazeTween.specialProperties["__bezier"] = PropertyBezier;
		}

		private var values : Array;
		private var isBezierThrough : Boolean;
		private var length : int;
		private var segments : Array;

		public function PropertyBezier(target : Object, property : *, value : *, next : EazeSpecial) {
			super(target, property, value, next);

			values = value;

			if (values[0] is Array) {
				isBezierThrough = true;
				values = values[0];
			}
		}

		override public function init(reverse : Boolean) : void {
			var current : Number = target[property];

			values = [current].concat(values);
			
			if (reverse) values.reverse();

			var p0 : Number, p1 : Number, p2 : Number = values[0];
			var last : int = values.length - 1;
			var index : int = 1;
			var auto : Number = NaN;
			segments = [];
			length = 0;

			while (index < last) {
				p0 = p2;
				p1 = values[index];
				p2 = values[++index];
				if (isBezierThrough) {
					if (!length) {
						auto = (p2 - p0) / 4;
						segments[length++] = new BezierSegment(p0, p1 - auto, p1);
					}
					segments[length++] = new BezierSegment(p1, p1 + auto, p2);
					auto = p2 - (p1 + auto);
				} else {
					if (index != last) p2 = (p1 + p2) / 2;
					segments[length++] = new BezierSegment(p0, p1, p2);
				}
			}
			values = null;

			if (reverse) update(0, false);
		}

		override public function update(decimalPercent : Number, isComplete : Boolean) : void {
			var segment : BezierSegment;
			var last : int = length - 1;

			if (isComplete) {
				segment = segments[last];
				target[property] = segment.p0 + segment.d2;
			} else if (length == 1) {
				segment = segments[0];
				target[property] = segment.calculate(decimalPercent);
			} else {
				var index : int = (decimalPercent * length) >> 0;
				if (index < 0) index = 0;
				else if (index > last) index = last;
				segment = segments[index];
				decimalPercent = length * (decimalPercent - index / length);
				target[property] = segment.calculate(decimalPercent);
			}
		}

		override public function dispose() : void {
			values = null;
			segments = null;

			super.dispose();
		}
	}
}
class BezierSegment {
	public var p0 : Number;
	public var d1 : Number;
	public var d2 : Number;

	function BezierSegment(p0 : Number, p1 : Number, p2 : Number) {
		this.p0 = p0;
		d1 = p1 - p0;
		d2 = p2 - p0;
	}

	public function calculate(t : Number) : Number {
		return p0 + t * (2 * (1 - t) * d1 + t * d2);
	}
}
