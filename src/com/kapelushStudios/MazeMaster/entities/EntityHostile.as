package com.kapelushStudios.MazeMaster.entities 
{
	import com.kapelushStudios.MazeMaster.map.Maze;
	import flash.display.Bitmap;
	import flash.geom.Point;
	/**
	 * ...
	 * @author matiki1231
	 */
	public class EntityHostile extends Entity 
	{
		private var sightRange:Number = 5;
		private var pointDir:Point = new Point();
		private var walkID:int;
		
		public function EntityHostile(self:Entity ,texture:Bitmap, type:EntityType, name:String) 
		{
			super(self, texture, type, name);
			speed = 10;
			walkID = Maze.getThread().sheduleRepeatingTask(entityPath, 2);
		}
		
		
		/**
		 * Finds path for EntityHostile and checks collisions. Also manages random movements while player not in range.
		 */
		public function entityPath():void {
			if (Math.sqrt(Math.pow(Math.abs(x - Maze.getPlayer().x), 2) + Math.pow(Math.abs(y - Maze.getPlayer().y), 2)) <= sightRange * 16) {
				
			} else {
				var dir:int = 0;//Math.round(Math.random() * 10000) % 4;
				switch (dir) 
				{
					case 0:
						pointDir.x = x;
						pointDir.y = y - 16;
						if (!Maze.getMap().getBlockAt(pointDir).walkable && (y % 16) == 0) {
							
						} else {
							y -= speed;
						}
					break;
					case 1:
						pointDir.x = x + 16;
						pointDir.y = y;
						if (!Maze.getMap().getBlockAt(pointDir).walkable && (x % 16) == 0) {
							
						} else {
							x += speed;
						}					
					break;
					case 2:
						pointDir.x = x;
						pointDir.y = y + 16;
						if (!Maze.getMap().getBlockAt(pointDir).walkable && (y % 16) == 0) {
							
						} else {
							y += speed;
						}					
					break;
					case 3:
						pointDir.x = x - 16;
						pointDir.y = y;
						if (!Maze.getMap().getBlockAt(pointDir).walkable && (y % 16) == 0) {
							
						} else {
							x -= speed;
						}					
					break;
				}
			}
		}
		
		public function followPlayer():void {
			
		}
		
	}

}