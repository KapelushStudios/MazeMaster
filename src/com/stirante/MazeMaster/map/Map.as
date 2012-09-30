package com.stirante.MazeMaster.map 
{
	import com.stirante.MazeMaster.blocks.Block;
	import com.stirante.MazeMaster.blocks.BlockList;
	import com.stirante.MazeMaster.entities.Entity;
	import flash.display.Sprite;
	/**
	 * Klasa zawierająca wszystkie informacje o mapie
	 * @author Piotr Brzozowski
	 */
	public class Map extends Sprite
	{
		private var map1:Sprite;
		private var map:Array
		private var entities:Array;
		private var tempX:int;
		private var tempY:int;
		private var blocks:Array;
		/**
		 * Klasa zawierająca wszystkie informacje o mapie
		 * @param	map Dwu-wymiarowa tablica zawierająca ułożenie wszystkich bloków
		 */
		public function Map(map:Array) 
		{
			this.map = map;
			entities = new Array();
			blocks = new Array();
			renderMap();
		}
		
		/**
		 * Renderuje mapę do obiektu Sprite
		 */
		public function renderMap():void
		{
			if (map1 != null)
			{
				clear();
			}
			else
			{
				map1 = new Sprite();
			}
			for (var i:int = 0; i < map.length; i++)
			{
				blocks[i] = new Array();
				for (var j:int = 0; j < map[0].length; j++)
				{
					blocks[i][j] = BlockList.getBlockById(map[i][j]);
					blocks[i][j].y = 16 * i;
					blocks[i][j].x = 16 * j;
					map1.addChild(blocks[i][j]);
				}
			}
			addChild(map1);
			
		}
		
		public function clear():void
		{
			removeChild(map1);
			map1 = new Sprite();
		}
		/**
		 * Spawnuje jednostke enitity na pozycji posX i posY
		 * @param	entity Jednostka do spawnu
		 * @param	posX Pozycja x
		 * @param	posY Pozycja y
		 */
		public function spawnEntity(entity:Entity, posX:int = -1, posY:int = -1):void
		{
			if (posX == -1 && posY == -1) {
				posX = Math.round(Math.random() * map[0].length) + 1;
				posY = Math.round(Math.random() * map.length) + 1;
			}
			else {
				//entity.x = posX;
				//entity.y = posY;
			}
			entities.push(entity);
			addChild(entity);
		}
		/**
		 * Usuwa jednostkę ze świata
		 * @param	entity Jednostka do usunięcia
		 */
		public function removeEntity(entity:Entity):void 
		{
			entity.setHealth(0);
			for (var i:int = 0; i < entities.length; i++) 
			{
				if (entities[i] == entity) {
					entities[i] = null;
				}
			}
		}
		/**
		 * Sprawdza czy podana pozycja koliduje z blokiem non-walkable
		 * @param	corner Obiekt zawierający pozycję x i y
		 * @return Zwraca true jeśli koliduje, false jeśli nie koliduje
		 */
		public function collideWith(corner:Object):Boolean 
		{
			if (!getBlockAt(corner).walkable) {
				return true;
			}
			return false;
		}
		/**
		 * Zwraca blok na pozycji określonej w obiekcie corner
		 * @param	corner Obiekt zaawierający pozycję x i y
		 * @return blok na podanej pozycji
		 */
		public function getBlockAt(corner:Object):Block 
		{
			tempX = Math.round(corner.x / 16);
			tempY = Math.round(corner.y / 16);
			return blocks[tempY][tempX];
		}
		/**
		 * Zwraca Sprite z mapą
		 * @return Sprite z mapą.
		 */
		public function getMap():Sprite
		{
			return map1;
		}
		public function getArray():Array
		{
			return map;
		}
	}

}