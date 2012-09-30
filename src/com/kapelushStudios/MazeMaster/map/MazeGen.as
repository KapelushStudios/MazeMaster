package com.kapelushStudios.MazeMaster.map 
{
	/**
	 * ...
	 * @author Mateusz Błażejewski
	 */
	public class MazeGen 
	{
		public static function generateMaze(sizeX:int, sizeY:int):Array
		{
			var result:Array = new Array()
			var visited:Array = new Array()
			var queue:Array =  new Array()
			var coorX:int
			var coorY:int
			var repeats:int = 1
			
			if (((sizeX % 2) != 1) || ((sizeY % 2) != 1)) 
			{
				throw new Error("MazeGen Object parameters have to be odd!")
			}
			
			for (var k:int = 0; k < ((sizeX - 1) / 2); k++) 
			{
				visited[ k ] = new Array()
			}
			
			for (var l:int = 0; l < ((sizeY - 1) / 2); l++) 
			{
				for (var m:int = 0; m < ((sizeX - 1) / 2); m++) 
				{
					visited[m][l] = 0
				}
			}
			
			for (var t:int = 0; t < sizeX; t++) 
			{
				result[ t ] = new Array()
			}
			
			for (var i:int = 0; i < sizeY; i++) 
			{
				for (var j:int = 0; j < sizeX; j++) 
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
			
			coorX = Math.round(Math.random() * 10000) % ((sizeX - 1) / 2)
			coorY = Math.round(Math.random() * 10000) % ((sizeY - 1) / 2)
			visited[coorX][coorY] = 1
			queue.push([coorX, coorY])
			
			while (repeats != (((sizeX - 1) / 2) * ((sizeY - 1) / 2)))
			{
				var dirTab:Array = [0, 0, 0, 0]
				var dirNum:int
				var direction:int
				
				if (coorX != ((sizeX - 1) / 2) - 1)
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
				
				if (coorY != ((sizeY - 1) / 2) - 1)
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
			
			return result
		}
		
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
	}

}