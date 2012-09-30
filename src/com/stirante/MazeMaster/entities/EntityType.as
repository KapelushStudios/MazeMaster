package com.stirante.MazeMaster.entities 
{
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class EntityType 
	{
		public static const PLAYER:EntityType = new EntityType("player");
		public static const ENEMY:EntityType = new EntityType("enemy");
		
		private var type:String;
		
		public function EntityType(type:String) 
		{
			this.type = type;
		}
		
	}

}