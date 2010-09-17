package
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.tweenman.TweenMan;
	
	public class TweenManDemo extends Sprite
	{
		public var mc:MovieClip;
		public var nextDemo:Function;
		
		public function TweenManDemo ()
		{
			stage.scaleMode = "noScale";
			nextDemo = demo1;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, clickHandler);
			function clickHandler (e:Event=null)
			{
				nextDemo();
			}
		}
		
		function demo1 ()
		{
			nextDemo = demo2;

			var glowProps = { blurX: 80, blurY: 80, strength: 1, inner: false, quality: 2 };
			TweenMan.addTween(mc, { frames: 30, glow: glowProps, color: { alphaMultiplier: 0.8, brightness: 1 } });
			TweenMan.addTween(mc, { frames: 20, rectangle: [0, 0, 200, 200], ease: "easeOutQuint" });
			TweenMan.addTween(mc, { frames: 20, blur: {blurX: 20, blurY:20, quality: 2} });
		}
		
		function demo2 ()
		{
			nextDemo = demo3;

			TweenMan.addTween(mc, { time: 1, glow: null, ease: "easeOutExpo" });
			TweenMan.addTween(mc, { frames: 50, color: { tintColor: Math.random()*0xFFFFFF, tintMultiplier: 0.5 } });
			TweenMan.addTween(mc, { frames: 20, blur: null });
		}
		
		function demo3 ()
		{
			nextDemo = demo4;

			TweenMan.addTween(mc, { time: 1, glow: { color: 0xFFCC00, blurX: 100, blurY: 100, strength: 2 } });
			TweenMan.addTween(mc, { time: 1, frame: "label2" });
		}
		
		function demo4 ()
		{
			nextDemo = demo1;

			TweenMan.addTween(mc, { frames: 30, glow: { color: 0, blurX: 14, blurY: 14, strength: 1, inner: true } });
			TweenMan.addTween(mc, { frames: 20, color: null, frame: 1, rectangle: [-50, -50, 150, 150], ease: "easeOutBack" });
		}
	}
}