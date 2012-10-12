package com.kapelushStudios.MazeMaster.utils
{
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class State 
	{
		public static const OPTIONS:State = new State("options");
		public static const GAME:State = new State("game");
		public static const EXIT:State = new State("exit");
		public static const MENU:State = new State("menu");
		public static var actualState:State = MENU;
		
		private static var _enumCreated:Boolean = false;
		
		{
			_enumCreated = true;
		}
		
		private var type:String;
		
		public function State(type:String) 
		{
			if (_enumCreated)
				throw new Error("Enum already created!");
			this.type = type;
		}
		
	}

}