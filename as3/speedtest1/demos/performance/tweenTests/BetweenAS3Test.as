package demos.performance.tweenTests {
	
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.Cubic;
	import org.libspark.betweenas3.tweens.ITween;
	
	public class BetweenAS3Test extends TweenTest {
		private var _tweenLookup:Dictionary = new Dictionary();
		
		public function BetweenAS3Test() {
			super("BetweenAS3", 4000);
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			//note: BetweenAS3 cannot accommodate standard easing equations like Cubic.easeIn, so we had to circumvent the "ease" parameter and hard-code it here.
			var t:ITween = BetweenAS3.delay(BetweenAS3.tween(target, {x:x, y:y, scaleX:scaleX, scaleY:scaleY, rotation:rotation}, null, duration, Cubic.easeIn), delay);
			t.onComplete = onComplete;
			t.onCompleteParams = onCompleteParams;
			t.play();
			_tweenLookup[target] = t; //must keep track of tweens in order to kill them later (I couldn't find an easy way to kill tweens in BetweenAS3)
		}
		
		override public function kill(targets:Array):void {
			for (var target:Object in _tweenLookup) {
				_tweenLookup[target].stop();
				delete _tweenLookup[target];
			}
		}
		
	}
}