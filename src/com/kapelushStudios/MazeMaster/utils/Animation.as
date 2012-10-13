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
		private var speed:int = 1;
		private var i:int = 0;
		private var texture:Bitmap;
		private var maska:Bitmap;
		private var frameNumber:int;
		
		public function Animation(texture:Bitmap, speed:int, frameNumber:int) 
		{
			this.frameNumber = frameNumber;
			this.texture = texture;
			this.speed = speed;
			addChild(this.texture);
			maska = new Bitmap(new BitmapData(16, 16, false, 0));
			this.texture.mask = maska;
			addEventListener(Event.ENTER_FRAME, enterFrame);
			addFrameScript(1, frame1);
			play();
		}
		
		private function frame1():void 
		{
			gotoAndPlay(0);
		}
		
		private function enterFrame(e:Event):void 
		{
			i++;
			if (i == speed) {
				i = 0;
				texture.x -= 16;
				if (Math.abs(texture.x / 16) == frameNumber) {
					texture.x = 0;
				}
			}
		}
		
		public function setTexture(texture:Bitmap):void
		{
			removeChild(this.texture);
			this.texture = texture;
			addChild(this.texture);
		}
		
	}

}