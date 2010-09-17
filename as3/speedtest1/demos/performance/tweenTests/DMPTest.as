package demos.performance.tweenTests {
	import com.desuade.motion.events.TweenEvent;
	import com.desuade.motion.tweens.BasicTween;
	import com.desuade.motion.tweens.MultiTween;
	import flash.utils.Dictionary;
	import flash.display.MovieClip;
	
	public class DMPTest extends TweenTest {
		private var _tweenLookup:Dictionary = new Dictionary();
		
		public function DMPTest() {
			super("Desuade (DMP)", 4000);
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			var t:MultiTween = new MultiTween(target, {properties:{x:x, y:y, scaleX:scaleX, scaleY:scaleY, rotation:rotation}, onComplete:onComplete, onCompleteParams:onCompleteParams, duration:duration, ease:ease, delay:delay});
			t.addEventListener(TweenEvent.ENDED, complete);
			t.start();
			_tweenLookup[target] = t;
		}
		
		protected function complete(event:TweenEvent):void {
			var config:Object = event.target.config;
			config.onComplete.apply(null, config.onCompleteParams);
		}
		
		override public function kill(targets:Array):void {
			var curTween:MultiTween;
			for (var target:Object in _tweenLookup) {
				curTween = _tweenLookup[target];
				curTween.stop();
				delete _tweenLookup[target];
			}
		}
		
	}
}