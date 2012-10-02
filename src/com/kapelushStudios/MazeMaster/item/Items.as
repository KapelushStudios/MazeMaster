package com.kapelushStudios.MazeMaster.item 
{
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Items
	{
		private static var items:Vector.<Item>;
		
		public static const GOLD_COIN:Item = new ItemCoin();
		
		public static function init():void
		{
			items = new Vector.<Item>(GOLD_COIN);
		}
		public static function getItemById(id:int):Item
		{
			return items[id].clone();
		}
		public static function getItemByIdToTest(id:int):Item
		{
			return items[id];
		}
		public static function getItemByName(name:String):Item
		{
			for each (var item:Item in items)
			{
				if (item.getName() == name) {
					return item.clone();
				}
			}
		}
	}

}