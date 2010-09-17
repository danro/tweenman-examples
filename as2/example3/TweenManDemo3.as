
import com.tweenman.TweenMan;
import com.tweenman.easing.*;

class TweenManDemo3 {
	
	public function TweenManDemo3 ($root) {
		Stage.scaleMode = "noScale";
		var buttons = [$root.btn1, $root.btn2, $root.btn3, $root.btn4]; 
		for (var i=0; i<buttons.length; i++) {
			buttons[i].onRollOver = rollOverHandler;
			buttons[i].onRollOut = rollOutHandler;
			buttons[i].useHandCursor = false;
		}
	}
	
	private function rollOverHandler () {
		var button:MovieClip = MovieClip(this);
		TweenMan.addTween(button, { frames: 10, frame: button._totalframes });
		TweenMan.addTween(button, { time: 2, blur: { blurX: 50 } });
	}
	
	private function rollOutHandler () {
		var button:MovieClip = MovieClip(this);
		TweenMan.addTween(button, { frames: 20, frame: 1 });
		TweenMan.addTween(button, { time: 2, blur: null });
	}

}