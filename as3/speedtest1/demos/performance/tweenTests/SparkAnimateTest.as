package demos.performance.tweenTests {	
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import spark.effects.*;
	import spark.effects.Animate;
	import spark.effects.animation.*;
	import spark.effects.easing.*;
	import flash.events.Event;
	
	public class SparkAnimateTest extends TweenTest {
		private var _tweenLookup:Dictionary = new Dictionary(false);
		
		public function SparkAnimateTest() {
			super("Spark Animate (Flex)", 800);
		}
		
		override public function onStart(targets:Array):void {
			var i:int = targets.length;
			var a:Animate;
			while (i--) {
				a = new Animate(targets[i]);
				a.addEventListener("effectEnd", _onComplete);
				_tweenLookup[targets[i]] = new TweenTracker(a);
			}
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			var t:TweenTracker = _tweenLookup[target];
			if (t == null) {
				return;
			} else if (!t.killed) {
				var a:Animate = t.a;
				a.stop();
				var mp:Vector.<MotionPath> = new Vector.<MotionPath>();
				mp.push( new SimpleMotionPath("x", null, x),
						 new SimpleMotionPath("y", null, y),
						 new SimpleMotionPath("scaleX", null, scaleX),
						 new SimpleMotionPath("scaleY", null, scaleY),
						 new SimpleMotionPath("rotation", null, rotation));
				a.motionPaths = mp;
				a.easer = new Power(1, 3);
				a.duration = duration * 1000;
				a.startDelay = int(delay * 1000);
				t.onComplete = onComplete;
				t.onCompleteParams = onCompleteParams;
				a.play();
			}
		}
		
		private function _onComplete(event:Event):void {
			var t:TweenTracker = _tweenLookup[event.target.target];
			if (t) {
				t.onComplete.apply(null, t.onCompleteParams);
			}
		}
		
		override public function kill(targets:Array):void {
			var t:TweenTracker;
			for (var target:Object in _tweenLookup) {
				t = _tweenLookup[target];
				t.killed = true;
				delete _tweenLookup[target];
				t.a.stop();
			}
		}
		
	}
}

import spark.effects.*;

internal class TweenTracker {
	public var a:Animate;
	public var onComplete:Function;
	public var onCompleteParams:Array;
	public var killed:Boolean;
	
	public function TweenTracker(a:Animate) {
		this.a = a;
	}
	
}