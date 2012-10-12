package com.kapelushStudios.MazeMaster.entities
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Path
	{
		private var path:Array;
		public function Path()
		{
			path = new Array();
		}
		
		public function getNext():Array
		{
			return path.shift();
		}
		
		public function get(y:int, x:int):int
		{
			return path[y][x];
		}
		
		public function unshift(...rest):uint
		{
			for each (var p:Point in rest)
			{
				path.unshift([p.x, p.y]);
			}
			return path.length;
		}
		public function push(...rest):uint
		{
			for each (var p:Point in rest)
			{
				path.push([p.x, p.y]);
			}
			return path.length;
		}
		
		public function tracePath():void
		{
			for each (var n:Array in path)
			{
				trace(n[0], n[1]);
			}
		}
		
		public function clear():void 
		{
			for (var i:int = 0; i < path.length; i++) 
			{
				path.pop();
			}
		}
		public function getLength():int
		{
			return path.length;
		}
	
	}

}