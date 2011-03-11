package demos.performance.tweenTests {
	import com.tweenman.TweenMan;
	
	import flash.display.MovieClip;
	
	public class TweenManTest extends TweenTest {
		
		public function TweenManTest() {
			super("TweenMan 2.2", 4000);
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			TweenMan.addTween(target, {time: duration, x:x, y:y, scaleX:scaleX, scaleY:scaleY, rotation:rotation, delay:delay, ease:ease, onComplete:onComplete, onCompleteParams:onCompleteParams});
		}
		
		override public function kill(targets:Array):void {
			TweenMan.dispose();
		}
	}
}