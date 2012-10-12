package com.kapelushStudios.MazeMaster 
{
	import com.kapelushStudios.MazeMaster.states.GameState;
	import com.kapelushStudios.MazeMaster.states.MenuState;
	import com.kapelushStudios.MazeMaster.states.OptionsState;
	import com.kapelushStudios.MazeMaster.utils.State;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class MazeMaster extends Sprite
	{
		static private var instance:MazeMaster;
		private var menuInstance:MenuState;
		private var gameInstance:GameState;
		private var optionsInstance:OptionsState;
		private var actualStateInstance:Sprite;
		
		public function MazeMaster() 
		{
			instance = this;
			addEventListener(Event.ENTER_FRAME, mainLoop);
			menuInstance = new MenuState();
			optionsInstance = new OptionsState();
			addChild(menuInstance);
			actualStateInstance = menuInstance;
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
				gameInstance = new GameState();
				actualStateInstance = gameInstance;
				addChild(actualStateInstance);
			}
			else if (state == State.MENU) {
				actualStateInstance = menuInstance;
				addChild(actualStateInstance);
			}
			else if (state == State.OPTIONS) {
				actualStateInstance = optionsInstance;
				addChild(actualStateInstance);
			}
		}
		
		public function getState():State
		{
			return State.actualState;
		}
		
	}

}