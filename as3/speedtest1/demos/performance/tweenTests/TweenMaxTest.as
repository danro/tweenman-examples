package demos.performance.tweenTests {
	import com.greensock.TweenMax;
	import com.greensock.TweenLite;
	import com.greensock.OverwriteManager;
	import com.greensock.easing.Cubic;
	
	import flash.display.MovieClip;
	
	public class TweenMaxTest extends TweenTest {
		
		public function TweenMaxTest() {
			super("TweenMax", 4000);
		}
		
		override public function onStart(targets:Array):void {
			OverwriteManager.init(2);
			//don't use the optimized version
			delete TweenLite.fastEaseLookup[Cubic.easeIn]; 
			delete TweenLite.fastEaseLookup[Cubic.easeOut]; 
			delete TweenLite.fastEaseLookup[Cubic.easeInOut]; 
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			new TweenMax(target, duration, {x:x, y:y, scaleX:scaleX, scaleY:scaleY, rotation:rotation, delay:delay, ease:ease, onComplete:onComplete, onCompleteParams:onCompleteParams});
		}
		
		override public function kill(targets:Array):void {
			var i:int = targets.length;
			while (i--) {
				TweenLite.killTweensOf(targets[i]);
			}
		}
		
	}
}