package com.kapelushStudios.MazeMaster.sound
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class SoundManager extends Sprite
	{
		private var callback:Function;
		private var snd:Sound;
		private var hasID3:Boolean;
		private var ctrl:SoundChannel = new SoundChannel();
		private var sndChannel:SoundChannel;
		private var pos:Number;
		private var sndTransform:SoundTransform = new SoundTransform(1, 0);
		private var playing:Boolean = false;
		private var isLoaded:Boolean = false;
		private var endCallback:Function;
		
		public function SoundManager(path:String, callback:Function = null)
		{
			if (path == null || path == "")
			{
				throw new Error("No path!");
			}
			snd = new Sound(new URLRequest(song));
			this.callback = callback;
			snd.addEventListener(Event.COMPLETE, loaded);
		}
		
		private function loaded(e:Event):void
		{
			isLoaded = true;
			if (callback != null)
			{
				callback();
			}
		}
		
		public function get getArtist():*
		{
			if (snd.id3.artist != "")
			{
				return snd.id3.artist;
			}
			else
			{
				return false;
			}
		}
		
		public function get getAlbum():*
		{
			if (snd.id3.album != "")
			{
				return snd.id3.album;
			}
			else
			{
				return false;
			}
		}
		
		public function get getSongName():*
		{
			if (snd.id3.songName != "")
			{
				return snd.id3.songName;
			}
			else
			{
				return false;
			}
		}
		
		public function play(callback:Function = null):void
		{
			endCallback = callback;
			playing = true;
			if (pos == 0)
			{
				sndChannel = snd.play(0, 0, sndTransform);
			}
			else
			{
				sndChannel = snd.play(pos, 0, sndTransform);
			}
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void 
		{
			if (playing && endCallback != null && sndChannel.position == snd.length && snd.length > 0) {
				endCallback();
			}
		}
		
		public function stop():void
		{
			playing = false;
			pos = 0;
			sndChannel.stop();
		}
		
		public function pause():void
		{
			playing = false;
			pos = sndChannel.position;
			sndChannel.stop();
		}
		
		public function set volume(vol:int):void
		{
			sndTransform.volume = vol / 100;
			sndChannel.soundTransform = sndTransform;
		}
		
		public function get isPlaying():Boolean
		{
			return playing;
		}
		
		public function get length():int {
			return snd.length;
		}
		
		public function get position():int {
			if (playing) {
				return sndChannel.position;
			}
			else {
				return 0;
			}
		}
		public function set position(value:int):void {
			if (playing) {
				sndChannel.stop();
				sndChannel = snd.play(value);
			}
			else {
				pos = value;
			}
		}
		
	}

}