package com.kapelushStudios.MazeMaster.map 
{
	/**
	 * ...
	 * @author Mateusz Błażejewski
	 */
	public class MazeGen 
	{
		static public var thick:int;
		
		/**
		 * Returns Array with generated Maze of certain size and multiplier
		 */
		public static function generateMaze(size:int, thick:int):Array
		{
			MazeGen.thick = thick;
			var result:Array = new Array()
			var visited:Array = new Array()
			var queue:Array =  new Array()
			var coorX:int
			var coorY:int
			var repeats:int = 1
			
			if (((size % 2) != 1) || ((size % 2) != 1)) 
			{
				throw new Error("MazeGen Object parameters have to be odd!")
			}
			
			for (var k:int = 0; k < ((size - 1) / 2); k++) 
			{
				visited[ k ] = new Array()
			}
			
			for (var l:int = 0; l < ((size - 1) / 2); l++) 
			{
				for (var m:int = 0; m < ((size - 1) / 2); m++) 
				{
					visited[m][l] = 0
				}
			}
			
			for (var t:int = 0; t < size; t++) 
			{
				result[ t ] = new Array()
			}
			
			for (var i:int = 0; i < size; i++) 
			{
				for (var j:int = 0; j < size; j++) 
				{
					if (i % 2 == 1)
					{
						if (j % 2 == 0) 
						{
							result[ i ][ j ] = 1						
						}
					
						if (j % 2 == 1) 
						{
							result[ i ][ j ] = 0						
						}
					}
					
					if (i % 2 == 0) 
					{
						result[ i ][ j ] = 1
					}
				}
			}
			
			coorX = Math.round(Math.random() * 10000) % ((size - 1) / 2)
			coorY = Math.round(Math.random() * 10000) % ((size - 1) / 2)
			visited[coorX][coorY] = 1
			queue.push([coorX, coorY])
			
			while (repeats != (((size - 1) / 2) * ((size - 1) / 2)))
			{
				var dirTab:Array = [0, 0, 0, 0]
				var dirNum:int
				var direction:int
				
				if (coorX != ((size - 1) / 2) - 1)
				{
				if (searchArray([coorX + 1, coorY], visited))
				{
					dirTab[ 0 ] = 1
				}
				}
				
				if (coorY != 0)
				{
				if (searchArray([coorX, coorY - 1], visited))
				{
					dirTab[ 1 ] = 1
				}
				}
				
				if (coorX != 0)
				{
				if (searchArray([coorX - 1, coorY], visited))
				{
					dirTab[ 2 ] = 1
				}
				}
				
				if (coorY != ((size - 1) / 2) - 1)
				{
				if (searchArray([coorX, coorY + 1], visited))
				{
					dirTab[ 3 ] = 1
				}
				}
				
				dirNum = dirTab[ 0 ] + dirTab[ 1 ] + dirTab[ 2 ] + dirTab[ 3 ] 
				
				if (dirNum != 0) 
				{
					direction = Math.round(Math.random() * 10000) % dirNum
					
					if (dirTab[ 0 ] == 1)
					{
						if (direction == 0) 
						{
							coorX ++
							result[(coorX * 2)][(coorY * 2) + 1] = 0
							repeats ++
							visited[coorX][coorY] = 1
							queue.push([coorX, coorY])	
							direction --
						}else direction --
					}
					if (dirTab[ 1 ] == 1)
					{
						if (direction == 0) 
						{
							coorY --
							result[(coorX * 2) + 1][(coorY * 2) + 2] = 0
							repeats ++
							visited[coorX][coorY] = 1
							queue.push([coorX, coorY])
							direction --
						}else direction --							
					}
					if (dirTab[ 2 ] == 1)
					{
						if (direction == 0) 
						{
							coorX --
							result[(coorX * 2) + 2][(coorY * 2) + 1] = 0
							repeats ++
							visited[coorX][coorY] = 1
							queue.push([coorX, coorY])
							direction --
						}else direction --							
					}
					if (dirTab[ 3 ] == 1)
					{
						if (direction == 0) 
						{
							coorY ++
							result[(coorX * 2) + 1][(coorY * 2)] = 0
							repeats ++
							visited[coorX][coorY] = 1
							queue.push([coorX, coorY])	
							direction --						
						}else direction --							
					}
					
				}else
				{
					var tempTab:Array = new Array()
					tempTab = queue.pop()
					coorX = tempTab[ 0 ]
					coorY = tempTab[ 1 ]
				}				
			}
			
			return blockFilter(21 * 4, 21 * 4, 0, 2, 10, enlargeArray(thick, size, size, result))
		}
		
		/**
		 * Returns false if on certain coordinates in certain Array there is 1 or true when 0.
		 */
		private static function searchArray(coordinates:Array, myArray:Array):Boolean 
		{
			var Xcor:int = coordinates[ 0 ]
			var Ycor:int = coordinates[ 1 ]
			if (myArray[Xcor][Ycor] == 1)
			{
				return false
			}
			
			return true
		}
		
		/**
		 * Multiplies certain Array by certain multiplier.
		 */
		private static function enlargeArray(enSize:int, enSizeX:int, enSizeY:int, enArray:Array):Array
		{
			var enResult:Array = new Array();
			
			for (var m:int = 0; m < (enSizeX * enSize); m++) 
			{
				enResult[ m ] = new Array() 
			}
			
			for (var i:int = 0; i < enSizeY; i++) 
			{
				for (var j:int = 0; j < enSize; j++) 
				{
					for (var k:int = 0; k < enSizeX; k++) 
					{
						for (var l:int = 0; l < enSize; l++) 
						{
							enResult[ (k * enSize) + l ][ (i * enSize) + j ] = enArray[ k ][ i ]
						}
					}
				}
			}
			
			return enResult
		}
		
		/**
		 * Searches for certain blocks in certain Array and changes then to another certain block.
		 */
		private static function blockFilter(filterX:int, filterY:int, blockID:int, filterID:int, filterChance:int, filterArray:Array):Array
		{
			for (var i:int = 0; i < filterY; i++) 
			{
				for (var j:int = 0; j < filterX; j++) 
				{
					if (filterArray[ j ][ i ] == blockID)
					{
						if (Math.round(Math.random() * 10000) % 100 < filterChance)
						{
							filterArray[ j ][ i ] = filterID
						}
					}
				}
			}
			
			return filterArray
		}
	}

}