package com.kapelushStudios.MazeMaster.map 
{
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class MazeGen 
	{
		public static function generateMaze(sizeX:int, sizeY:int):Array
		{
			var result:Array = [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
								[1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1],
								[1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1],
								[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]];
			
			//TODO: maze generator
			
			return result;
		}
	}

}