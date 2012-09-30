package com.kapelushStudios.MazeMaster.entities
{
	import com.kapelushStudios.MazeMaster.MazeMaster;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class EntityHostile extends Entity
	{
		private var pathfind:Pathfinding;
		public function EntityHostile(self:EntityHostile, texture1:Bitmap, name1:String) 
		{
			super(self, texture1, EntityType.ENEMY, name1, Math.round(14 * Math.random())+1, Math.round(14 * Math.random())+1);
			pathfind = new Pathfinding(MazeMaster.getMap().getArray());
		}
		
		public function findPath():Path
		{
			return pathfind.findPath(Math.round(this.x / 16), Math.round(this.y / 16), Math.round(MazeMaster.getPlayer().x / 16), Math.round(MazeMaster.getPlayer().y / 16));
		}
		
	}

}