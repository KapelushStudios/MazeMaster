package com.kapelushStudios.MazeMaster.entities
{
	import com.kapelushStudios.MazeMaster.map.Maze;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class EntityHostile extends Entity
	{
		protected var pathfind:Pathfinding;
		protected var path:Path;
		public function EntityHostile(self:EntityHostile, texture1:Bitmap, name1:String) 
		{
			super(self, texture1, EntityType.ENEMY, name1, Math.round(14 * Math.random())+1, Math.round(14 * Math.random())+1);
			pathfind = new Pathfinding(Maze.getMap().getArray());
		}
		
		public function findPath():void
		{
			pathfind.findPath(Math.round(this.x / 16), Math.round(this.y / 16), Math.round(Maze.getPlayer().x / 16), Math.round(Maze.getPlayer().y / 16), path);
		}
		
		public function getPath():Path
		{
			return path;
		}
		
	}

}