package demos.performance.tweenTests {
	import com.gskinner.motion.GTween;
	
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	
	public class GTweenTest extends TweenTest {
		private var _tweenLookup:Dictionary = new Dictionary();
		
		public function GTweenTest() {
			super("GTween v2.01", 4000);
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			_tweenLookup[target] = new GTween(target, duration, {x:x, y:y, scaleX:scaleX, scaleY:scaleY, rotation:rotation}, {ease:ease, delay:delay, onComplete:onGTweenComplete, data:{f:onComplete, p:onCompleteParams}});
		}
		
		private static function onGTweenComplete(t:GTween):void {
			t.data.f.apply(null, t.data.p);
		}
		
		override public function kill(targets:Array):void {
			var curTween:GTween;
			for (var target:Object in _tweenLookup) {
				curTween = _tweenLookup[target];
				curTween.paused = true;
				delete _tweenLookup[target];
			}
		}
		
	}
}