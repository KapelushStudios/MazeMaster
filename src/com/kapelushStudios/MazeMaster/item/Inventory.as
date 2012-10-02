package com.kapelushStudios.MazeMaster.item 
{
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Inventory 
	{
		private var items:Vector.<Item>;
		private var money:int = 0;
		public function Inventory() 
		{
			items = new Vector.<Item>();
		}
		public function getMoney():int
		{
			return money;
		}
		public function setMoney(value:int):void
		{
			money = value;
		}
		public function addMoney(value:int):void
		{
			money += value;
		}
		public function removeMoney(value:int): void
		{
			money -= value;
		}
		public function addItem(id:int):void
		{
			items.push(Items.getItemById(id));
		}
		public function removeItem(id:int, amount:int = -1):void
		{
			if (amount != -1)
			{
				for (var i:int = 0; i < amount; i++) 
				{
					for (var j:int = 0; j < items.length; j++) 
					{
						if (items.indexOf(Items.getItemByIdToTest(id)) > 0){
							items[items.indexOf(Items.getItemByIdToTest(id))] = null;
						}
						else {
							break;
						}
					}
				}
			}
		}
		public function importInventory(arg:Array):void
		{
			
		}
	}

}