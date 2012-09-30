package com.stirante.MazeMaster.entities
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Path extends Array
	{
		
		public function Path(... rest)
		{
			super(rest)
		}
		
		public function getNext():Array
		{
			return shift();
		}
		
		override AS3 function unshift(...rest):uint
		{
			for each (var p:Point in rest)
			{
				super.unshift([p.x, p.y]);
			}
			return length;
		}
		override AS3 function push(...rest):uint
		{
			for each (var p:Point in rest)
			{
				super.push([p.x, p.y]);
			}
			return length;
		}
		
		public function tracePath():void
		{
			for each (var n:Array in this)
			{
				trace(n[0], n[1]);
			}
		}
	
	}

}