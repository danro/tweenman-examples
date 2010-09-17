package demos.performance.tweenTests {
	
	import com.flashdynamix.motion.TweensyTimelineZero;
	import com.flashdynamix.motion.TweensyZero;
	
	import flash.display.MovieClip;
	
	
	public class TweensyZeroTest extends TweenTest {
		
		public function TweensyZeroTest() {
			super("TweensyZero", 2400);
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			var t:TweensyTimelineZero = TweensyZero.to(target, {x:x, y:y, scaleX:scaleX, scaleY:scaleY, rotation:rotation}, duration, ease, delay);
			t.onComplete = onComplete;
			t.onCompleteParams = onCompleteParams;
		}
		
		override public function kill(targets:Array):void {
			TweensyZero.stopAll();
		}
		
	}
}