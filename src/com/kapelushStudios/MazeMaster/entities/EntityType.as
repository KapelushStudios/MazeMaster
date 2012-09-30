package com.kapelushStudios.MazeMaster.entities 
{
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class EntityType 
	{
		public static const PLAYER:EntityType = new EntityType("player");
		public static const ENEMY:EntityType = new EntityType("enemy");
		
		private static var _enumCreated:Boolean = false;
		{
			_enumCreated = true;
		}
		
		private var type:String;
		
		public function EntityType(type:String) 
		{
			if (_enumCreated)
				throw new Error("Enum already created!");
			this.type = type;
		}
		
	}

}