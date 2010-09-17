package demos.performance {
	import com.greensock.easing.Cubic;
	//import spark.effects.*;
	import demos.performance.tweenTests.*;
	
	import fl.controls.*;
	import fl.data.*;
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.text.TextField;
	import flash.utils.*;
	
	//import com.flashdynamix.utils.SWFProfiler;

	public class TweeningSpeedTest extends MovieClip {
		private var _tests:Array;
		private var _dp:DataProvider;
		private var _startTime:Number; 
		private var _frameCount:uint;
		private var _timer:Timer = new Timer(500); 
		private var _targets:Array = [];
		private var _active:Boolean;
		private var _curTest:TweenTest;
		private var _radius:uint = 320;
		
		public var toggle_btn:Button;
		public var engine_cb:ComboBox;
		public var warning_mc:MovieClip;
		public var container_mc:MovieClip;
		public var instances_ns:NumericStepper;
		public var duration_ns:NumericStepper;
		public var fps_tf:TextField;
		
		public function TweeningSpeedTest() {
			super();
			init();
			//SWFProfiler.init(this);
		}

		private function init():void {
			_tests = [
					  new TweenManTest(),
					 // new TweenLiteFastTest(),
					  new TweenLiteTest(),
					 // new TweenMaxFastTest(),
					 // new TweenMaxTest(),
					 // new TweenerTest(),
					  new GTweenTest(),
					 // new TweensyTest(),
					 // new TweensyZeroTest(),
					 // new DMPTest(),
					 // new HydroTweenTest(),
					 // new BetweenAS3Test(),
					 // new ByteTweenTest(this.stage),
					 // new KitchenSyncTest(),
					 // new SparkAnimateTest(),
					 // new AdobeTweenTest()];
					];
			
			
			_dp = new DataProvider();
			var i:int, test:TweenTest;
			for (i = 0; i < _tests.length; i++) {
				test = _tests[i];
				_dp.addItem({label:test.name, data:test});
			}
			this.engine_cb.addEventListener(Event.RENDER, populateComboBox); //doesn't render initially - needs time to render.
			_timer.addEventListener(TimerEvent.TIMER, report);
			this.toggle_btn.addEventListener(MouseEvent.CLICK, toggleActive);
			this.warning_mc.visible = false;
			this.container_mc.mouseChildren = this.container_mc.mouseEnabled = false;
			
			initWarning();
		}
		
		private function initWarning():void {
			this.warning_mc.bg_mc.addEventListener(MouseEvent.CLICK, captureClick, false, 0, true);
			this.warning_mc.bg_mc.useHandCursor = false;
			this.warning_mc.proceed_btn.addEventListener(MouseEvent.CLICK, onConfirmWarning, false, 0, true);
			this.warning_mc.cancel_btn.addEventListener(MouseEvent.CLICK, closeWarning, false, 0, true);
		}
		
		private function populateComboBox(e:Event=null):void {
			this.engine_cb.removeEventListener(Event.RENDER, populateComboBox);
			this.engine_cb.dataProvider = _dp;
			this.engine_cb.validateNow();
		}
		
		private function startTweens(confirmed:Boolean=false):void {
			_curTest = this.engine_cb.selectedItem.data;
			if (_curTest.name == "Desuade (DMP)" && !confirmed) {
				this.warning_mc.visible = true;
				this.warning_mc.message_tf.text = "The Desuade Motion Package appears to have some garbage collection issues that prevent tweens from being fully killed before they complete, so please reload the swf (refresh the broswer) after running this test.";
				this.toggle_btn.label = "START";
				return;
			} else if (_curTest.warnAtCount < this.instances_ns.value && !confirmed) {
				this.warning_mc.visible = true;
				this.warning_mc.message_tf.text = "The tweening engine you chose may have a difficult time handling this number of instances at the duration you chose which could crash the player. Proceed with extreme caution or change your selection.";
				this.toggle_btn.label = "START";
				return;
			} else {
				this.toggle_btn.label = "STOP";
			}
			
			_frameCount = 0;
			this.stage.addEventListener(Event.ENTER_FRAME, update);
			_timer.reset();
			_timer.start();
			_active = true;
			_targets = [];
			
			var s:Star, i:int;
			var n:int = this.instances_ns.value;
			for (i = 0; i < n; i++) {
				s = new Star();
				this.container_mc.addChild(s);
				_targets[_targets.length] = s;
			}
			_curTest.onStart(_targets);
			for (i = 0; i < n; i++) {
				tween(_targets[i], Math.random());
			}
			_startTime = getTimer();
		}
		
		
		private function tween(star:Star, progress:Number):void {
			star.x = 262; //center
			star.y = 215; //center
			var scale:Number = Math.random() * 2.5 + 0.5;
			star.scaleX = star.scaleY = 0.05;
			var random:Number = Math.random();
			var angle:Number = random * Math.PI * 2;
			var delay:Number = Math.random() * this.duration_ns.value;
			if (progress != 0) {
				star.x += Math.cos(angle) * _radius * progress;
				star.y += Math.sin(angle) * _radius * progress;
				star.scaleX = star.scaleY = scale * progress;
				delay = 0;
			}
			_curTest.tween(star, 									//target
						   this.duration_ns.value * (1 - progress), //duration
						   262 + Math.cos(angle) * _radius,			//x
						   215 + Math.sin(angle) * _radius,			//y
						   scale, 									//scaleX
						   scale,									//scaleY
						   random * rotation,						//rotation
						   delay,									//delay
						   Cubic.easeIn,							//ease
						   tween,									//onComplete
						   [star, 0]);								//onCompleteParams
		}
		
		private function stopTweens():void {
			_curTest.kill(_targets);
			var i:int = _targets.length;
			while (i--) {
				this.container_mc.removeChild(_targets[i]);
			}
			_targets = [];
			_timer.stop();
			this.stage.removeEventListener(Event.ENTER_FRAME, update);
			_active = false;
		}
		
		private function toggleActive(e:MouseEvent):void {
			if (_active) {
				this.toggle_btn.label = "START";
				stopTweens();
			} else {
				this.toggle_btn.label = "STOP";
				startTweens();
			}
			this.engine_cb.enabled = this.instances_ns.enabled = this.duration_ns.enabled = !_active;
		}
		
		private function update(e:Event):void {
			_frameCount++;
		}
		
		private function report(e:TimerEvent):void {
			var t:Number = (getTimer() - _startTime) * 0.001;
			if (t > 4) {
				this.fps_tf.text = String(Math.round((_frameCount / t) * 10) / 10);
			} else {
				this.fps_tf.text = "wait...";
			}
		}
		
		private function onConfirmWarning(e:MouseEvent):void {
			closeWarning(null);
			startTweens(true);
		}
		
		private function closeWarning(e:MouseEvent=null):void {
			this.warning_mc.visible = false;
		}
		
		private function captureClick(e:MouseEvent):void {
			//do nothing
		}
		
	}
}