package
{	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.tweenman.TweenMan;

	public class TweenManDemo3 extends Sprite
	{	
		public var btn1:MovieClip;
		public var btn2:MovieClip;
		public var btn3:MovieClip;
		public var btn4:MovieClip;
		
		public function TweenManDemo3 ()
		{
			stage.scaleMode = "noScale";
			var buttons = [btn1, btn2, btn3, btn4]; 
			for (var i=0; i<buttons.length; i++)
			{
				buttons[i].addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
				buttons[i].addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			}
		}

		private function rollOverHandler (e:Event)
		{
			var button:MovieClip = MovieClip(e.target);
			TweenMan.add(button, { frames: 10, frame: button.totalFrames });
			TweenMan.add(button, { time: 0.5, blur: { blurX: 50 } });
		}
	
		private function rollOutHandler (e:Event)
		{
			var button:MovieClip = MovieClip(e.target);
			TweenMan.add(button, { frames: 20, frame: 1, delay: 5 });
			TweenMan.add(button, { time: 1, blur: null, ease: "easeInOutQuint" });
		}	
	}
}