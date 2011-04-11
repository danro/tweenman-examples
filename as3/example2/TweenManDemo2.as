package
{	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;

	import com.tweenman.TweenMan;

	public class TweenManDemo2 extends Sprite
	{	
		public var mc:MovieClip;
		
		public function TweenManDemo2 ()
		{
			stage.scaleMode = "noScale";
			demo1();
		}
		
		function demo1 ()
		{	
			var colorProps = { hue: Math.random()*360, contrast: 0.4 };
			TweenMan.add(mc, { frames: 30, colorMatrix: colorProps, ease: "easeInCubic" });
			TweenMan.add(this, { frames: 18, onComplete: demo2 });
		}
		
		function demo2 ()
		{
			var blurProps = { blurX: 10, blurY: 10, quality: 2 };
			TweenMan.add(mc, { frames: 10, color: { burn: 0.7 }, delay: 8, ease: "easeInOutCubic" });
			TweenMan.add(mc, { frames: 20, blur: blurProps, delay: 3, ease: "easeInOutCubic" });
			TweenMan.add(this, { frames: 18, onComplete: demo3 });
		}
		
		function demo3 ()
		{		
			TweenMan.add(mc, { frames: 40, colorMatrix: null, blur: null, ease: "easeInOutCubic" })
			TweenMan.add(mc, { frames: 70, color: null, ease: "easeInOutCubic" });
			TweenMan.add(this, { frames: 70, onComplete: demo1 });
		}
	}
}