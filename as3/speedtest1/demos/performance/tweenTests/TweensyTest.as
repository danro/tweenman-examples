package demos.performance.tweenTests {
	
	import com.flashdynamix.motion.Tweensy;
	import com.flashdynamix.motion.TweensyTimeline;
	
	import flash.display.MovieClip;
	
	
	public class TweensyTest extends TweenTest {
		
		public function TweensyTest() {
			super("Tweensy", 4000);
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			var t:TweensyTimeline = Tweensy.to(target, {x:x, y:y, scaleX:scaleX, scaleY:scaleY, rotation:rotation}, duration, ease, delay);
			t.onComplete = onComplete;
			t.onCompleteParams = onCompleteParams;
		}
		
		override public function kill(targets:Array):void {
			var i:int = targets.length;
			while (i--) {
				Tweensy.stop(targets[i]);
			}
		}
		
	}
}