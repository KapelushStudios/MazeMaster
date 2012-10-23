package com.kapelushStudios.MazeMaster.entities 
{
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Action 
	{
		public static const UP:Action = new Action("up");
		public static const DOWN:Action = new Action("down");
		public static const LEFT:Action = new Action("left");
		public static const RIGHT:Action = new Action("right");
		public static const SPRINT:Action = new Action("sprint");
		public static const NO_SPRINT:Action = new Action("no sprint");
		public static const JUMP:Action = new Action("space");
		
		private static var _enumCreated:Boolean = false;
		
		{
			_enumCreated = true;
		}
		
		private var type:String;
		
		public function Action(type:String) 
		{
			if (_enumCreated)
				throw new Error("Enum already created!");
			this.type = type;
		}
		
	}

}