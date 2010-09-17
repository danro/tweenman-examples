package demos.performance.tweenTests {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.utils.Dictionary;
	
	import org.as3lib.kitchensync.KitchenSync;
	import org.as3lib.kitchensync.action.tween.*;
	import org.as3lib.kitchensync.core.KitchenSyncEvent;
	import org.as3lib.kitchensync.easing.Cubic;
	import org.as3lib.kitchensync.action.group.KSParallelGroup;
	
	public class KitchenSyncTest extends TweenTest {
		private var _tweenLookup:Dictionary = new Dictionary();
		
		public function KitchenSyncTest() {
			super("KitchenSync", 1400);
		}
		
		override public function onStart(targets:Array):void {
			var i:int = targets.length;
			while (i--) {
				_tweenLookup[targets[i]] = new KSParallelGroup();// new KSTweenTracker();
			}
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			/*
			NOTE: KitchenSync cannot accommodate standard easing equations like Cubic.easeIn, 
			so we had to circumvent the "ease" parameter and hard-code it here.
			Also, the engine appears to intermittently render tweens incorrectly
			*/
			var ks:KSParallelGroup = _tweenLookup[target];
			if (ks) {
				
				ks.addAction( new KSSimpleTween(target, "x", target.x, x, duration * 1000, delay * 1000, Cubic.easeIn) );
				ks.addAction( new KSSimpleTween(target, "y", target.y, y, duration * 1000, delay * 1000, Cubic.easeIn) );
				ks.addAction( new KSSimpleTween(target, "scaleX", target.scaleX, scaleX, duration * 1000, delay * 1000, Cubic.easeIn) );
				ks.addAction( new KSSimpleTween(target, "scaleY", target.scaleY, scaleY, duration * 1000, delay * 1000, Cubic.easeIn) );
				ks.addAction( new KSSimpleTween(target, "rotation", target.rotation, rotation, duration * 1000 + 1, delay * 1000, Cubic.easeIn) );
				
				ks.addEventListener(KitchenSyncEvent.ACTION_COMPLETE, function():void {onComplete.apply(null, onCompleteParams)});
				ks.start();
				/*
				ks.x = new KSSimpleTween(target, "x", target.x, x, duration * 1000, delay * 1000, Cubic.easeIn);
				ks.y = new KSSimpleTween(target, "y", target.y, y, duration * 1000, delay * 1000, Cubic.easeIn);
				ks.scaleX = new KSSimpleTween(target, "scaleX", target.scaleX, scaleX, duration * 1000, delay * 1000, Cubic.easeIn);
				ks.scaleY = new KSSimpleTween(target, "scaleY", target.scaleY, scaleY, duration * 1000, delay * 1000, Cubic.easeIn);
				ks.rotation = new KSSimpleTween(target, "rotation", target.rotation, rotation, duration * 1000 + 1, delay * 1000, Cubic.easeIn);
				ks.x.start();
				ks.y.start();
				ks.scaleX.start();
				ks.scaleY.start();
				ks.rotation.start();
				ks.rotation.addEventListener(KitchenSyncEvent.ACTION_COMPLETE, function():void {onComplete.apply(null, onCompleteParams)});
				*/
			}
		}
		
		override public function kill(targets:Array):void {
			/*
			var i:int = targets.length, ks:KSTweenTracker; 
			while (i--) {
				ks = _tweenLookup[targets[i]];
				ks.x.kill();
				ks.y.kill();
				ks.scaleX.kill();
				ks.scaleY.kill();
				ks.rotation.kill();
				ks.killed = true;
				delete _tweenLookup[targets[i]];
			}
			*/
			var i:int = targets.length, ks:KSParallelGroup; 
			while (i--) {
				ks = _tweenLookup[targets[i]];
				ks.kill();
				delete _tweenLookup[targets[i]];
			}
		}
		
	}
	
	
}
/*
import org.as3lib.kitchensync.action.tween.*;

internal class KSTweenTracker {
	public var x:KSSimpleTween;
	public var y:KSSimpleTween;
	public var scaleX:KSSimpleTween;
	public var scaleY:KSSimpleTween;
	public var rotation:KSSimpleTween;
	public var killed:Boolean;
	
	public function KSTweenTracker() {
		
	}
}
*/