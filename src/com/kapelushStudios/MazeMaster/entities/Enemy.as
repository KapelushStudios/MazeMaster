package com.kapelushStudios.MazeMaster.entities 
{
	import com.kapelushStudios.MazeMaster.MazeMaster;
	import com.kapelushStudios.MazeMaster.utils.Texture;
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Enemy extends EntityHostile 
	{
		private var searchID:int;
		private var walkID:int;
		private var path:Path;
		
		public function Enemy() 
		{
			super(this, Texture.getBlock(2, 2), "Enemy");
			
			// TODO: Get it to work
			
			//searchID = MazeMaster.getThread().sheduleRepeatingTask(searchPlayer, 50);
		}
		
		public function searchPlayer():void 
		{
			path = findPath();
			if (path != null) 
			{
				walkID = MazeMaster.getThread().sheduleRepeatingTask(walkToPlayer, 1);
			}
		}
		
		public function walkToPlayer():void 
		{
			var loc:Array = path[0];
			if (loc[0] > Math.round(this.x / 16))
			{
				this.x++;
			}
			if (loc[0] < Math.round(this.x / 16))
			{
				this.x--;
			}
			if (loc[1] > Math.round(this.y / 16))
			{
				this.y++;
			}
			if (loc[1] < Math.round(this.y / 16))
			{
				this.y--;
			}
			if (loc[0] == Math.round(this.x / 16) && loc[1] == Math.round(this.y / 16))
			{
				path.getNext();
			}
			
		}
		
	}

}