package demos.performance.tweenTests {
	import caurina.transitions.Tweener;
	
	import flash.display.MovieClip;
	
	public class TweenerTest extends TweenTest {
		
		public function TweenerTest() {
			super("Tweener", 1600);
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			Tweener.addTween(target, {time:duration, x:x, y:y, scaleX:scaleX, scaleY:scaleY, rotation:rotation, delay:delay, transition:"easeInCubic", onComplete:onComplete, onCompleteParams:onCompleteParams});
		}
		
		override public function kill(targets:Array):void {
			var i:int = targets.length;
			while (i--) {
				Tweener.removeTweens(targets[i]);
			}
		}
		
	}
}