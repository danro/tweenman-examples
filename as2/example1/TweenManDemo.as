
import mx.utils.Delegate;

import com.tweenman.TweenMan;
import com.tweenman.easing.*;

class TweenManDemo {

	var mc:MovieClip;
	var nextDemo:Function;	
	
	public function TweenManDemo ($root) {
		mc = $root.mc;
		Stage.scaleMode = "noScale";
		nextDemo = demo1;
		$root.onMouseDown = Delegate.create(this, clickHandler);
		function clickHandler () { nextDemo(); }
	}
	
	function demo1 () {
		nextDemo = demo2;
		
		var glowProps = { blurX: 80, blurY: 80, strength: 1, inner: false, quality: 2 };
		TweenMan.addTween(mc, { frames: 30, glow: glowProps, color: { alphaMultiplier: 0.8, brightness: 1 } });
		TweenMan.addTween(mc, { frames: 20, rectangle: [0, 0, 200, 200], ease: Quintic.easeOut });
	}
	
	function demo2 () {
		nextDemo = demo3;
		
		TweenMan.addTween(mc, { time: 1, glow: null, ease: Exponential.easeOut });
		TweenMan.addTween(mc, { frames: 50, color: { tintColor: Math.random()*0xFFFFFF, tintMultiplier: 0.5 } });
	}
	
	function demo3 () {
		nextDemo = demo4;

		TweenMan.addTween(mc, { time: 1, glow: { color: 0xFFCC00, blurX: 100, blurY: 100, strength: 2 } });
		TweenMan.addTween(mc, { time: 1, frame: 80 });
	}
	
	function demo4 () {
		nextDemo = demo1;

		TweenMan.addTween(mc, { frames: 30, glow: { color: 0, blurX: 14, blurY: 14, strength: 1, inner: true } });
		TweenMan.addTween(mc, { time: 0.5, color: null, frame: 1, rectangle: [-50, -50, 150, 150], ease: Back.easeOut });
	}
}