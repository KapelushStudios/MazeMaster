package com.stirante.MazeMaster.blocks
{
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class BlockList
	{
		static private var blockList:Vector.<Block>;
		/**
		 * Metoda inicjuje klasę do dalszego działania
		 */
		public static function init():void
		{
			blockList = new Vector.<Block>();
			blockList.push(new BlockSlab(), new BlockBrick());
		}
		/**
		 * Zwraca blok o podanym ID
		 * @param	id ID bloku
		 * @return Blok o podanym ID
		 */
		public static function getBlockById(id:int):Block
		{
			return blockList[id].clone();
		}
		/**
		 * Zwraca blok o podanej nazwie
		 * @param	str Nazwa bloku
		 * @return Blok o podanej nazwie
		 */
		public static function getBlockByName(str:String):Block
		{
			for (var i:int = 0; i < blockList.length; i++) 
			{
				if (str == blockList[i].name) {
					return blockList[i].clone();
				}
			}
			return null;
		}
		/**
		 * Zwraca blok do testów o podanym ID. Oznacza to, że nie tworzy nowej instancji bloku tylko zwraca starą.
		 * @param	id ID bloku
		 * @return Blok o podanym ID
		 */
		static public function getBlockToTest(id:int):Block 
		{
			return blockList[id];
		}
	
	}

}