package com.kapelushStudios.MazeMaster.map
{
	import com.kapelushStudios.MazeMaster.blocks.Block;
	import com.kapelushStudios.MazeMaster.blocks.BlockList;
	import com.kapelushStudios.MazeMaster.entities.Entity;
	import com.kapelushStudios.MazeMaster.shaders.ShaderFilters;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	
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
		private var renderDistance:int;
		private var maps:Array;
		
		/*
		 * Klasa zawierająca wszystkie informacje o mapie
		 * @param	map Dwu-wymiarowa tablica zawierająca ułożenie wszystkich bloków
		 */
		public function Map(map:Array)
		{
			this.map = map;
			entities = new Array();
			blocks = new Array();
			renderDistance = 4;
			renderMap();
			//Maze.getThread().sheduleRepeatingTask(renderMap, 1, 0, false);
		}
		
		/**
		 * Renderuje mapę do obiektu Sprite
		 */
		public function renderMap():void
		{
			if (map1 != null)
			{
				stage.removeChild(map1);
			}
			
			var bitmapNumber:int = (int)((map.length / MazeGen.thick) / (int)(255 / MazeGen.thick));
			
			if ((map.length % 255) != 0) 
			{
				bitmapNumber++;
			}
			maps = new Array();
			map1 = new Sprite();
			for (var k:int = 0; k < bitmapNumber; k++) 
			{
				maps[k] = new Array();
				for (var l:int = 0; l < bitmapNumber; l++) 
				{
					maps[k][l] = new Bitmap(new BitmapData((int)(4080 / MazeGen.thick) * MazeGen.thick, (int)(4080 / MazeGen.thick) * MazeGen.thick, false, 0));
				}
			}
			var dest:Point = new Point();
			var actual:Array = new Array(0, 0);
			for (var i:int = 0; i < map.length; i++) 
			{
				for (var j:int = 0; j < map[0].length; j++) 
				{
					dest.x = /*(j - ((int)(j/255))*255) * 16*/ (j % 255) * 16;
					dest.y = /*(i - ((int)(j/255))*255) * 16*/ (i % 255) * 16;
					maps[actual[0]][actual[1]].bitmapData.copyPixels(BlockList.getBlockToTest(map[i][j]).getTexture().bitmapData, BlockList.getBlockToTest(map[i][j]).getTexture().bitmapData.rect, dest);
					if (((j + 1) % 255) == 0 && j != 0) {
						actual[1]++;
					}
				}
				actual[1] = 0;
				if (((i + 1) % 255)  == 0 && i != 0) {
					actual[0]++;
				}
			}
			
			for (var m:int = 0; m < bitmapNumber; m++) 
			{
				for (var n:int = 0; n < bitmapNumber; n++) 
				{
					maps[m][n].x = ((int)(4080 / MazeGen.thick) * MazeGen.thick) * n;
					maps[m][n].y = ((int)(4080 / MazeGen.thick) * MazeGen.thick) * m;
					map1.addChild(maps[m][n]);
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
			if (posX == -1 && posY == -1)
			{
				posX = Math.round(Math.random() * map[0].length) + 1;
				posY = Math.round(Math.random() * map.length) + 1;
			}
			else
			{
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
				if (entities[i] == entity)
				{
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
			if (!getBlockAt(corner).walkable)
			{
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
			tempX = (int)(corner.x / 16);
			tempY = (int)(corner.y / 16);
			return BlockList.getBlockToTest(map[tempY][tempX]);
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
		
		public function setMotionBlur(value:Boolean, dir:int):void
		{
			if (value) {
				map1.filters = [ShaderFilters.getMotionBlur(1, dir)]
			}
			else {
				map1.filters = [];
			}
		}
		
	}

}