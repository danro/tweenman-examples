
import com.tweenman.TweenMan;
import com.tweenman.easing.*;

class TweenManDemo2 {
	
	var mc:MovieClip;
	
	public function TweenManDemo2 ($root) {
		mc = $root.mc;
		Stage.scaleMode = "noScale";
		demo1();
	}
	
	function demo1 () {	
		var colorProps = { colorize: Math.random()*0xFFFFFF, colorizeAmount: 0.2, saturation: 0.2, contrast: 0.6 };
		TweenMan.addTween(mc, { frames: 30, colormatrix: colorProps, ease: Cubic.easeIn });
		TweenMan.addTween(this, { frames: 18, onComplete: [this, demo2] });
	}

	function demo2 () {
		var blurProps = { blurX: 10, blurY: 10, quality: 2 };
		TweenMan.addTween(mc, { frames: 10, color: { burn: 0.65 }, delay: 8, ease: Cubic.easeInOut });
		TweenMan.addTween(mc, { frames: 20, blur: blurProps, delay: 3, ease: Cubic.easeInOut });
		TweenMan.addTween(this, { frames: 18, onComplete: [this, demo3] });
	}
	
	function demo3 () {		
		TweenMan.addTween(mc, { frames: 40, colormatrix: null, blur: null, ease: Cubic.easeInOut })
		TweenMan.addTween(mc, { frames: 80, color: null, ease: Cubic.easeInOut });
		TweenMan.addTween(this, { frames: 70, onComplete: [this, demo1] });
	}
}