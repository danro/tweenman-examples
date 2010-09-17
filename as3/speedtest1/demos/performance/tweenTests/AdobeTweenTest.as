package demos.performance.tweenTests {
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	
	public class AdobeTweenTest extends TweenTest {
		private var _tweenLookup:Dictionary = new Dictionary(false);
		
		public function AdobeTweenTest() {
			super("Adobe's Tween", 800);
		}
		
		override public function onStart(targets:Array):void {
			var i:int = targets.length;
			while (i--) {
				_tweenLookup[targets[i]] = new TweenTracker();
			}
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			var t:TweenTracker = _tweenLookup[target];
			if (t == null) {
				return;
			} else if (delay != 0) {
				setTimeout(tween, delay * 1000, target, duration, x, y, scaleX, scaleY, rotation, 0, ease, onComplete, onCompleteParams);
			} else if (!t.killed) {
				t.x = new Tween(target, "x", ease, target.x, x, duration, true);
				t.y = new Tween(target, "y", ease, target.y, y, duration, true);
				t.scaleX = new Tween(target, "scaleX", ease, target.scaleX, scaleX, duration, true);
				t.scaleY = new Tween(target, "scaleY", ease, target.scaleY, scaleY, duration, true);
				t.rotation = new Tween(target, "rotation", ease, target.rotation, rotation, duration, true);
				t.rotation.addEventListener(TweenEvent.MOTION_FINISH, function():void {onComplete.apply(null, onCompleteParams)});
			}
		}
		
		override public function kill(targets:Array):void {
			var t:TweenTracker;
			for (var target:Object in _tweenLookup) {
				t = _tweenLookup[target];
				t.x.stop();
				t.y.stop();
				t.scaleX.stop();
				t.scaleY.stop();
				t.rotation.stop();
				t.killed = true;
				delete _tweenLookup[target];
			}
		}
		
	}
}
import fl.transitions.Tween;
import demos.performance.tweenTests.AdobeTweenTest;
import flash.display.DisplayObject;

internal class TweenTracker {
	public var x:Tween;
	public var y:Tween;
	public var scaleX:Tween;
	public var scaleY:Tween;
	public var rotation:Tween;
	public var killed:Boolean;
	
	public function TweenTracker() {
		
	}
	
}