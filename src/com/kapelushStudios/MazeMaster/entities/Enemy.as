package com.kapelushStudios.MazeMaster.entities 
{
	import com.kapelushStudios.MazeMaster.map.Maze;
	import com.kapelushStudios.MazeMaster.utils.Texture;
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Enemy extends EntityHostile 
	{
		private var tempX:int;
		private var tempY:int;
		protected var searchID:int = 0;
		protected var walkID:int = 0;
		
		public function Enemy() 
		{
			super(this, Texture.getBlock(2, 2), "Enemy");
			
			speed = 0.5;
			
			// TODO: Get it to work
			
			searchID = Maze.getThread().sheduleRepeatingTask(searchPlayer, 50);
			walkID = Maze.getThread().sheduleRepeatingTask(walkToPlayer, 1);
			Maze.getThread().getTask(walkID).setPaused(true);
			
		}
		
		public function searchPlayer():void 
		{
			if (path != null) {
				if (tempX == Math.round(Maze.getPlayer().x / 16) && tempY == Math.round(Maze.getPlayer().y / 16)) {
					
				}
				else {
					findPath();
				}
				tempX = Math.round(Maze.getPlayer().x / 16);
				tempY = Math.round(Maze.getPlayer().y / 16);
			}
			else {
				path = new Path();
				findPath();
			}
			if (path != null) 
			{
				Maze.getThread().getTask(walkID).setPaused(false);
			}
		}
		
		public function walkToPlayer():void 
		{
			if (path.getLength() == 0) {
				Maze.getThread().getTask(walkID).setPaused(true);
			}
			if (path.get(0, 0) > (int)(this.x / 16))
			{
				this.x++;
			}
			if (path.get(0, 0) < (int)(this.x / 16))
			{
				this.x--;
			}
			if (path.get(0, 1) > (int)(this.y / 16))
			{
				this.y++;
			}
			if (path.get(0, 1) < (int)(this.y / 16))
			{
				this.y--;
			}
			if (path.get(0, 0) == (int)(this.x / 16) && path.get(0, 1) == (int)(this.y / 16))
			{
				path.getNext();
			}
			
		}
		
	}

}