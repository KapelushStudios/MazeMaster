package com.kapelushStudios.MazeMaster.utils
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Control extends Sprite
	{
		private var callback:Function;
		private var up:Boolean;
		private var down:Boolean;
		private var right:Boolean;
		private var left:Boolean
		private var space:Boolean;;
		
		/**
		 *
		 * @param	callback zwraca naciśnięty klawisz.Jest wykonywany onEnterFrame
		 */
		public function Control(callback:Function)
		{
			this.callback = callback;
			if (stage){
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			addEventListener(Event.ENTER_FRAME, enterFrame);
			}
			else {
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function keyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.UP)
			{
				up = true;
			}
			if (e.keyCode == Keyboard.DOWN)
			{
				down = true;
			}
			if (e.keyCode == Keyboard.RIGHT)
			{
				right = true;
			}
			if (e.keyCode == Keyboard.LEFT)
			{
				left = true;
			}
			if (e.keyCode == Keyboard.SPACE)
			{
				space = true;
			}
		}
		
		private function keyUp(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.UP)
			{
				up = false;
			}
			if (e.keyCode == Keyboard.DOWN)
			{
				down = false;
			}
			if (e.keyCode == Keyboard.RIGHT)
			{
				right = false;
			}
			if (e.keyCode == Keyboard.LEFT)
			{
				left = false;
			}
			if (e.keyCode == Keyboard.SPACE)
			{
				space = false;
			}
		}
		
		private function enterFrame(e:Event):void
		{
			if (up)
			{
				callback("up");
			}
			if (down)
			{
				callback("down");
			}
			if (right)
			{
				callback("right");
			}
			if (left)
			{
				callback("left");
			}
			if (space)
			{
				callback("space");
			}
		}
	
	}

}