package com.kapelushStudios.MazeMaster.utils
{
	import com.kapelushStudios.MazeMaster.map.Maze;
	import com.kapelushStudios.MazeMaster.MazeMaster;
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
		private var idleCallback:Function;
		private var refreshID:int;
		
		/**
		 *
		 * @param	callback zwraca naciśnięty klawisz.Jest wykonywany onEnterFrame
		 */
		public function Control(callback:Function, idleCallback:Function)
		{
			this.idleCallback = idleCallback;
			this.callback = callback;
			MazeMaster.addKeyDownCallback(keyDown);
			MazeMaster.addKeyUpCallback(keyUp);
			refreshID = Maze.getThread().sheduleRepeatingTask(enterFrame, 1);
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
			if (!up && !down && !left && !right) {
				idleCallback();
			}
		}
		
		private function enterFrame(e:Event = null):void
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