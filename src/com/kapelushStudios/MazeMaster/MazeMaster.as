package com.kapelushStudios.MazeMaster 
{
	import com.kapelushStudios.MazeMaster.states.GameState;
	import com.kapelushStudios.MazeMaster.states.MenuState;
	import com.kapelushStudios.MazeMaster.states.OptionsState;
	import com.kapelushStudios.MazeMaster.utils.State;
	import com.kapelushStudios.MazeMaster.utils.Texture;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.system.fscommand;
	import flash.system.System;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class MazeMaster extends Sprite
	{
		static private var instance:MazeMaster;
		static private var downCallbacks:Array = new Array();
		static private var upCallbacks:Array = new Array();
		private var menuInstance:MenuState;
		private var gameInstance:GameState;
		private var optionsInstance:OptionsState;
		private var actualStateInstance:Sprite;
		private var cursor:Bitmap;
		
		public function MazeMaster() 
		{
			instance = this;
			addEventListener(Event.ENTER_FRAME, mainLoop);
			menuInstance = new MenuState();
			optionsInstance = new OptionsState();
			addChild(menuInstance);
			actualStateInstance = menuInstance;
			cursor = Texture.getCursor();
			addChild(cursor);
			Mouse.hide();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, stage_keyUp);
			fscommand("fullscreen", "true");
		}
		
		private function stage_keyUp(e:KeyboardEvent):void 
		{
			for (var i:int = 0; i < upCallbacks.length; i++) 
			{
				if (upCallbacks[i] != null){
					upCallbacks[i](e);
				}
			}
		}
		
		private function stage_keyDown(e:KeyboardEvent):void 
		{
			for (var i:int = 0; i < downCallbacks.length; i++) 
			{
				if (downCallbacks[i] != null){
					downCallbacks[i](e);
				}
			}
		}
		
		private function stage_mouseMove(e:MouseEvent):void 
		{
			cursor.x = mouseX;
			cursor.y = mouseY;
		}
		
		private function mainLoop(e:Event):void 
		{
			if (getState() == State.GAME) {
				gameInstance.getMaze().run();
			}
		}
		
		public static function getInstance():MazeMaster
		{
			return instance;
		}
		
		public function setState(state:State):void
		{
			if (state == getState()) {
				return;
			}
			State.actualState = state;
			removeChild(actualStateInstance);
			if (state == State.GAME) {
				removeChild(cursor);
				gameInstance = new GameState();
				actualStateInstance = gameInstance;
				addChild(actualStateInstance);
			}
			else if (state == State.MENU) {
				actualStateInstance = menuInstance;
				addChild(actualStateInstance);
				addChild(cursor);
			}
			else if (state == State.OPTIONS) {
				removeChild(cursor);
				actualStateInstance = optionsInstance;
				addChild(actualStateInstance);
				addChild(cursor);
			}
			else if (state == State.EXIT) {
				fscommand("quit");
			}
		}
		
		public function getState():State
		{
			return State.actualState;
		}
		
		public static function addKeyDownCallback(method:Function):int
		{
			return downCallbacks.push(method);
		}
		
		public static function addKeyUpCallback(method:Function):int
		{
			return upCallbacks.push(method);
		}
		
		public static function removeKeyUpCallback(id:int):void
		{
			upCallbacks[id] = null;
		}
		
		public static function removeKeyDownCallback(id:int):void
		{
			downCallbacks[id] = null;
		}
		
	}

}