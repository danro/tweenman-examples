package demos.performance.tweenTests {
	import com.greensock.OverwriteManager;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	
	public class TweenLiteTest extends TweenTest {
		
		public function TweenLiteTest() {
			super("TweenLite", 4000);
		}
		
		override public function onStart(targets:Array):void {
			OverwriteManager.init(1);
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			new TweenLite(target, duration, {x:x, y:y, scaleX:scaleX, scaleY:scaleY, rotation:rotation, delay:delay, ease:ease, onComplete:onComplete, onCompleteParams:onCompleteParams});
		}
		
		override public function kill(targets:Array):void {
			var i:int = targets.length;
			while (i--) {
				TweenLite.killTweensOf(targets[i]);
			}
		}
		
	}
}