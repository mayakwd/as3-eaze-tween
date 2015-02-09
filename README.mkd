as3-eaze-tween
==============

EazeTween based on [eaze-tween written by philippe.elsass](https://code.google.com/p/eaze-tween/)


Changelog
---------------------
Feb 9, 2015
- Added multi-target support

Jan 20, 2015
- repeat() method added

Eaze was designed to:
---------------------

- bring back lightness and simplicity in Flash tweening,
- introduce a smartest syntax and event system,
- provide the best performance compromise,
- with minimal classes quantity and no dependencies.
- The result is a compact (~4Kb raw engine and ~9Kb with all plugins), highly optimized library, with a jQuery-like syntax.

Basic syntax and events
-----------------------

Basic tweening is classic:
```actionscript
eaze(target).to(duration, { x:dx, y:dy });
eaze(target).from(duration, { x:dx, y:dy });
eaze(target).apply({ x:dx, y:dy }); // set values immediately
eaze(target).play("label"); // see timeline tweening below

eaze(target).to(duration, { width:dw }, false /*don't overwrite existing tweens*/);
```

Multi-target tweening:
```actionscript
eaze([circle, rectangle]).to(duration, {x: dx, y:dy });
eaze(new <Shape>[circle, rectangle]).to(duration, {x: dx, y:dy });
```

Original, completion-friendly, event system:
```actionscript
eaze(target).to(duration, { x:dx, y:dy })
    .onUpdate(handler, param1, etc)
    .onComplete(handler, param1, param2, etc);

// identical to:
TweenMax.to(target, duration {
    x:dx, y:dy,
    onUpdate:handler, onUpdateParams:[param1, etc],
    onComplete:handler, onCompleteParams:[param1, param2, etc]
});
```

And to set the easing function (optimized Robert Penner functions):
```actionscript
eaze(target).to(duration, { x:dx, y:dy })
    .easing(Cubic.easeInOut);
// default function is Quadratic.easeOut
```

Tween chaining, delaying and repeating
--------------------------------------
Tweens can be chained (chained tweens are started at the end of parent tween):
```actionscript
eaze(target)
    .from(duration, { x:dx, y:dy }) 
    .to(duration, { x:dx, y:dy })
    .play("over")
    .chain(otherTarget).to(duration, { x:dx, y:dy })
    .apply({ x:dx, y:dy });
// tweens will be executed one by one
```

A delay is "just" a blank tween:
```actionscript
eaze(target).delay(1).onComplete(handler, arg1);

// identical to
TweenMax.delayedCall(1, handler, [arg1]);
// and also BTW
setTimeout(handler, 1000, arg1);
```

Now you can chain a tween to the delay tween:
```actionscript
eaze(target).delay(1)
    .to(duration, { x:dx, y:dy });

// identical to:
TweenMax.to(target, duration, {
    delay:1,
    x:dx, y:dy
});
```

Unlike with TweenMax.from(), if a tween is delayed the target will NOT be updated before the delay has expired. But you can call .updateNow() to replicate this useful behavior:
```actionscript
eaze(target).delay(1)
    .from(duration, { x:dx })
    .updateNow(); // update target immediately

// identical to:
TweenMax.from(target, duration, { 
    delay:1,
    x:dx
});
```

Also you can repeat tween with method "repeat":
```actionscript
eaze(target)
	.to(0.8, {x: 100})
	.repeat(2);
```
Number of repeat can be positive, or negative for endless repeating (-1 by default - endless).
You can't repeat full chain of tweens, only one by one.

Special properties
------------------
Automatic relation between alpha & visible:
```actionscript
eaze(target).to(duration, { alpha:0 }); // set visible to false when alpha==0
eaze(target).to(duration, { alphaVisible:0 }); // do not change visibility

// identical to
TweenMax.to(target, duration { autoAlpha:0 });
TweenMax.to(target, duration { alpha:0 });
```

Original tint mixing:
```acrionscripteaze(target).to(1).tint(0xffffff);
eaze(target).to(1).tint(0xffffff, colorize, multiply);
// colorize[0..1]: color offset ratio (tint strength)
// multiply[0..2]: original color multiplicator (keep original color)

// remove tint
eaze(target).to(1).tint();

// but you can also use a more classic syntax:
eaze(target).to(1, { tint:0xffffff });
eaze(target).to(1, { tint:[0xffffff, colorize, multiply] });
eaze(target).to(1, { tint:null }); // remove tint
```

Original filter syntax:
```actionscript
eaze(target).to(duration)
    .filter(BlurFilter, { blurX:5, blurY:5, quality:2 });

eaze(target).to(duration)
    .filter(GlowFilter, { blurX:20, blurY:20, color:0x00ccff, knockout:true });

// but you can also use a more classic syntax:
eaze(target).to(duration, { 
        blurFilter:{ blurX:5, blurY:5 }
```

Smart color transforms tweening:
```actionscript
// .colorMatrix(brightness[-1..1], contrast[-1..1], saturation[-1..1], 
//              hue[-180..180], tint[RGB], colorize[0..1])
eaze(target).to(duration)
    .colorMatrix(0.2, 0, -1); // brightness, contrast, saturation, etc.

// remove transformation
eaze(target).to(duration).colorMatrix();

// or using standard filter tween syntax
eaze(target).to(duration)
    .filter(ColorMatrixFilter, { 
        brightness:0.2, saturation:-1
    });
});

// filter built using Quasimondo's (stripped-down) ColorMatrix class
```

Classic volume syntax:
```actionscript
eaze(target).to(duration, { volume:0.5 });
```

Original Bezier tween syntax:
```actionscript
// Bezier tween to end value with one or more control points
eaze(target).to(duration, { x:[100, 150] });
eaze(target).to(duration, { x:[100, 120, 150] });

// Bezier "through" tween to end value with one or more points to cross
eaze(target).to(duration, { x:[[100, 150]] });
eaze(target).to(duration, { x:[[100, 120, 150]] });

// respectively identical to
TweenMax.to(target, duration, { bezier:[{x:100}, {x:150}] });
TweenMax.to(target, duration, { bezier:[{x:100}, {x:120}, {x:150}] });

// and
TweenMax.to(target, duration, { bezierThrough:[{x:100}, {x:150}] });
TweenMax.to(target, duration, { bezierThrough:[{x:100}, {x:120}, {x:150}] });
```

Original short rotation syntax:
```actionscript
// works with any property
eaze(target).to(1).short(160);
eaze(target).to(1).short(Math.PI/4, "angleProp", true /*use radian*/);
```

Built-in scale (scaleX/scaleY) tweening:
```actionscript
eaze(target).to(duration, { scale:0.5 });
```

Useful Rectangle tweening:
```actionscript
// animate .scrollRect
eaze(target).to(1).rect(new Rectangle(0,0,100,100));
// or other rectangle properties
eaze(target).to(1).rect(new Rectangle(0,0,100,100), "rectProp");
```

Of course all these special tweening properties work backward using eaze(target).from().

Timeline frame tweening
-----------------------
Original frame tweening options:
```actionscript
// tween clip timeline at appropriate linear speed
eaze(target).play(); // totalFrames
eaze(target).play(12);
eaze(target).play("label");
eaze(target).play("start+end"); // from label "start" to label "start+end"
eaze(target).play("start>end"); // from label "start" to label "end"

// but you can also use a more classic syntax:
eaze(target).to(duration, { frame:"label" });
```

How to use the raw engine (4Kb) only?
-------------------------------------
Plugins will be loaded as soon as your code imports the special eaze() function.

Plugins will NOT be loaded if you use the raw tween engine:
```actionscript
// raw engine, no plugin dependency (cool for your loader animations)
new EazeTween(target).to(...)

// using eaze() will automatically import the plugins
eaze(target).to(...)
```