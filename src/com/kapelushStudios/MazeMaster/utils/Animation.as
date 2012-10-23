package com.kapelushStudios.MazeMaster.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Animation extends MovieClip
	{
		private var speed:Number = 1;
		private var i:Number = 0;
		private var texture:Bitmap;
		private var maska:Bitmap;
		private var frameNumber:int;
		private var frameWidth:int;
		private var repeatOnce:Boolean;
		
		public function Animation(texture:Bitmap, speed:Number, frameNumber:int, frameWidth:int, frameHeight:int, repeatOnce:Boolean)
		{
			this.repeatOnce = repeatOnce;
			this.frameWidth = frameWidth;
			this.frameNumber = frameNumber;
			this.texture = texture;
			this.speed = speed;
			addChild(this.texture);
			maska = new Bitmap(new BitmapData(frameWidth, frameHeight, false));
			addChild(maska);
			this.texture.mask = maska;
			addEventListener(Event.ENTER_FRAME, enterFrame);
			//addFrameScript(1, frame1);
			//play();
		}
		
		private function frame1():void
		{
			gotoAndPlay(0);
		}
		
		private function enterFrame(e:Event):void
		{
			i++;
			if (i == speed)
			{
				i = 0;
				texture.x -= frameWidth;
				if (Math.abs(texture.x / frameWidth) == frameNumber)
				{
					if (repeatOnce)
					{
						stop();
					}
					else {
						texture.x = 0;
					}
				}
			}
		}
		
		public function setTexture(texture:Bitmap):void
		{
			removeChild(this.texture);
			this.texture = texture;
			addChild(this.texture);
		}
	
		override public function play():void 
		{
			super.play();
			gotoAndPlay(0);
			addEventListener(Event.ENTER_FRAME, enterFrame);
			texture.x = 0;
		}
		
		override public function stop():void 
		{
			super.stop();
			removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
	}

}