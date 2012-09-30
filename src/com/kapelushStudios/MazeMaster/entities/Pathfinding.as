package com.kapelushStudios.MazeMaster.entities
{
	import com.kapelushStudios.MazeMaster.blocks.BlockList;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class Pathfinding
	{
		
		private var vTile:Array;
		private var vWrite:Array;
		
		private var nWidth:int;
		private var nHeight:int;
		
		public function Pathfinding(tiles:Array):void
		{
			vTile = tiles;
			nWidth = tiles.length;
			nHeight = tiles[0].length;
			
			vWrite = new Array(nWidth);
			for (var i:int = 0; i < nWidth; i++)
			{
				vWrite[i] = new Array(nHeight);
			}
		}
		
		public function findPath(startx:int, starty:int, endx:int, endy:int):Path
		{
			if (startx < 0 || startx >= vTile.length)
				return null;
			if (starty < 0 || starty >= vTile[startx].length)
				return null;
			
			for (var i:int = 0; i < nWidth; i++)
			{
				for (var j:int = 0; j < vTile[i].length; j++)
				{
					vWrite[i][j] = 0;
				}
			}
			
			vWrite[startx][starty] = 1;
			vWrite[endx][endy] = 2;
			
			var vCheck:Vector.<Point>;
			var vReadStart:Vector.<Point> = new Vector.<Point>();
			var vReadEnd:Vector.<Point> = new Vector.<Point>();
			
			var tile:Point;
			var nStep:int = 3;
			vReadStart.push(new Point(startx, starty));
			vReadEnd.push(new Point(endx, endy));
			
			var time:Number;
			while (vReadStart.length != 0 && vReadEnd.length != 0)
			{
				
				vCheck = vReadStart;
				vReadStart = new Vector.<Point>();
				for each (tile in vCheck)
					if (lookupTile(tile.x, tile.y, nStep, vReadStart, vWrite, vTile))
					{
						return retracePath(tile.x, tile.y, nStep, vWrite, false);
					}
				nStep++;
				
				vCheck = vReadEnd;
				vReadEnd = new Vector.<Point>();
				for each (tile in vCheck)
					if (lookupTile(tile.x, tile.y, nStep, vReadEnd, vWrite, vTile))
					{
						return retracePath(tile.x, tile.y, nStep, vWrite, true)
					}
				nStep++;
			}
			
			return null;
		}
		
		private function lookupTile(i:int, j:int, step:int, vTemp:Vector.<Point>, vWrite:Array, vTile:Array):Boolean
		{
			
			i = i - 1;
			if (i > -1)
			{
				if (vWrite[i][j] == step - 1)
					return true;
				if (BlockList.getBlockById(vTile[i][j]).walkable && vWrite[i][j] == 0)
				{
					vTemp.push(new Point(i, j));
					vWrite[i][j] = step;
				}
			}
			
			i = i + 2;
			if (i < nWidth)
			{
				if (vWrite[i][j] == step - 1)
					return true;
				if (BlockList.getBlockById(vTile[i][j]).walkable && vWrite[i][j] == 0)
				{
					vTemp.push(new Point(i, j));
					vWrite[i][j] = step;
				}
			}
			
			i = i - 1;
			j = j - 1;
			if (j > -1)
			{
				if (vWrite[i][j] == step - 1)
					return true;
				if (BlockList.getBlockById(vTile[i][j]).walkable && vWrite[i][j] == 0)
				{
					vTemp.push(new Point(i, j));
					vWrite[i][j] = step;
				}
			}
			j = j + 2;
			if (j < nHeight)
			{
				if (vWrite[i][j] == step - 1)
					return true;
				if (BlockList.getBlockById(vTile[i][j]).walkable && vWrite[i][j] == 0)
				{
					vTemp.push(new Point(i, j));
					vWrite[i][j] = step;
				}
			}
			return false;
		}
		
		private function retracePath(tilex:int, tiley:int, step:int, vTile:Array, isFromEnd:Boolean):Path
		{
			var pStart:Point;
			var pEnd:Point;
			if (isFromEnd)
			{
				pEnd = new Point(tilex, tiley);
				pStart = getTargetTile(tilex, tiley, step - 1, vTile);
			}
			else
			{
				pStart = new Point(tilex, tiley);
				pEnd = getTargetTile(tilex, tiley, step - 1, vTile);
			}
			
			var vPath:Path = new Path();
			var nStep:int = isFromEnd ? step - 1 : step - 2;
			while (pStart != null && nStep > 0)
			{
				vPath.unshift(pStart);
				pStart = getTargetTile(pStart.x, pStart.y, nStep - 2, vTile);
				nStep -= 2;
			}
			
			nStep = isFromEnd ? step - 2 : step - 1;
			while (pEnd != null && nStep > 0)
			{
				vPath.push(pEnd);
				pEnd = getTargetTile(pEnd.x, pEnd.y, nStep - 2, vTile);
				nStep -= 2;
			}
			return vPath;
		}
		
		private function getTargetTile(tilex:int, tiley:int, step:int, vTile:Array):Point
		{
			tilex = tilex - 1;
			if (tilex > -1 && vTile[tilex][tiley] == step)
				return new Point(tilex, tiley);
			
			tilex = tilex + 2;
			if (tilex < nWidth && vTile[tilex][tiley] == step)
				return new Point(tilex, tiley);
			
			tilex = tilex - 1;
			tiley = tiley - 1;
			if (tiley > -1 && vTile[tilex][tiley] == step)
				return new Point(tilex, tiley);
			
			tiley = tiley + 2;
			if (tiley < nHeight)
				if (vTile[tilex][tiley] == step)
					return new Point(tilex, tiley);
			
			return null;
		}
	}
}
