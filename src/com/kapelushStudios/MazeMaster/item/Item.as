package com.kapelushStudios.MazeMaster.item 
{
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Item 
	{
		private var id:int;
		private var name:String;
		
		public function Item(id:int, name:String) 
		{
			this.name = name;
			this.id = id;
			
		}
		public function getName():String
		{
			return name;
		}
		public function getId():int
		{
			return id;
		}
		public function clone():Item
		{
			return new Item(id, name);
		}
	}

}