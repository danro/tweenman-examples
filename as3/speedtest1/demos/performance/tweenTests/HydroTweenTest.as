package demos.performance.tweenTests {
	import com.hydrotik.go.HydroTween;
	
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	import org.goasap.GoEngine;
	import org.goasap.interfaces.IUpdatable;
	
	
	public class HydroTweenTest extends TweenTest {
		private var _tweenLookup:Dictionary = new Dictionary();
		
		public function HydroTweenTest() {
			super("HydroTween (GoASAP)", 2000);
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			_tweenLookup[target] = HydroTween.go(target, {x:x, y:y, scaleX:scaleX, scaleY:scaleY, rotation:rotation}, duration, delay, ease, function():void {onComplete.apply(null, onCompleteParams)});
		}
		
		override public function kill(targets:Array):void {
			for each (var curTween:IUpdatable in _tweenLookup) {
				GoEngine.removeItem(curTween);
			}
		}
		
	}
}