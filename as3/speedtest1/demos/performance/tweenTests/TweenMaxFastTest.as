package demos.performance.tweenTests {
	import com.greensock.OverwriteManager;
	import com.greensock.plugins.*;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.FastEase;
	
	import flash.display.MovieClip;
	
	public class TweenMaxFastTest extends TweenTest {
		
		public function TweenMaxFastTest() {
			super("TweenMax (FAST*)", 4000);
			TweenPlugin.activate([FastTransformPlugin]);
		}
		
		override public function onStart(targets:Array):void {
			OverwriteManager.init(2);
			FastEase.activate([Cubic]);
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			new TweenMax(target, duration, {fastTransform:{x:x, y:y, scaleX:scaleX, scaleY:scaleY, rotation:rotation}, delay:delay, ease:ease, onComplete:onComplete, onCompleteParams:onCompleteParams});
		}
		
		override public function kill(targets:Array):void {
			var i:int = targets.length;
			while (i--) {
				TweenLite.killTweensOf(targets[i]);
			}
		}
		
	}
}