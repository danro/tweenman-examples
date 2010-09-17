package demos.performance.tweenTests {
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	import org.thelab.motion.ByteTween;
	import org.thelab.motion.modules.ColorModule;
	import org.thelab.motion.modules.ControlModule;
	import org.thelab.motion.modules.OverlapModule;
	import org.thelab.motion.transition.CubicEase;
	
	
	public class ByteTweenTest extends TweenTest {
		
		public function ByteTweenTest(stage:Stage) {
			super("ByteTween", 1600);
			ByteTween.init(stage, true, true, OverlapModule, ControlModule, ColorModule);
		}
		
		override public function tween(target:MovieClip, duration:Number, x:Number, y:Number, scaleX:Number, scaleY:Number, rotation:Number, delay:Number, ease:Function, onComplete:Function, onCompleteParams:Array):void {
			/*
			NOTE: ByteTween cannot accommodate standard easing equations like Cubic.easeIn, 
			so we had to circumvent the "ease" parameter and hard-code it here.
			*/
			ByteTween.add(target, "x", x, duration, delay, CubicEase.In);
			ByteTween.add(target, "y", y, duration, delay, CubicEase.In);
			ByteTween.add(target, "scaleX", scaleX, duration, delay, CubicEase.In);
			ByteTween.add(target, "scaleY", scaleY, duration, delay, CubicEase.In);
			ByteTween.add(target, "rotation", rotation, duration, delay, CubicEase.In, onComplete, onCompleteParams[0], onCompleteParams[1]);
		}
		
		override public function kill(targets:Array):void {
			var i:int = targets.length, target:Object;
			while (i--) {
				target = targets[i];
				ByteTween.cancel(target, "x");
				ByteTween.cancel(target, "y");
				ByteTween.cancel(target, "scaleX");
				ByteTween.cancel(target, "scaleY");
				ByteTween.cancel(target, "rotation");
			}
		}
		
	}
}