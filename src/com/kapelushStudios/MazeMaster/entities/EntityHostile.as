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
		private var sightRange:Number = 10;
		private var pointDir0:Point = new Point();
		private var pointDir1:Point = new Point();
		private var walkID:int;
		private var xDir:int;
		private var yDir:int;
		private var iters:int = 64;
		
		public function EntityHostile(self:Entity ,texture:Bitmap, type:EntityType, name:String) 
		{
			super(self, texture, type, name);
			speed = 1;
			walkID = Maze.getThread().sheduleRepeatingTask(entityPath, 1);
		}
		
		/**
		 * Finds path for EntityHostile and checks collisions. Also manages random movements while player not in range.
		 */
		public function entityPath():void {
			if (Math.sqrt(Math.pow(Math.abs(x - Maze.getPlayer().x), 2) + Math.pow(Math.abs(y - Maze.getPlayer().y), 2)) <= sightRange * 16) {
				followPlayer();
			} else {
				walkRandomly();
			}
		}
		
		/**
		 * Allows Entity to walk randomly and checks collisions.
		 */
		public function walkRandomly():void {
			if (iters == 128) {
			xDir = (x + 64) - ((int)(Math.random() * 10000) % 129);
			yDir = (y + 64) - ((int)(Math.random() * 10000) % 129);	
			iters = 0;
			}
			
			if (y > yDir) 
			{
				y -= checkWalkable(0);
			}
			if (x < xDir) 
			{
				x += checkWalkable(1);
			}
			if (y < yDir) 
			{
				y += checkWalkable(2);
			}
			if (x > xDir) 
			{
				x -= checkWalkable(3);
			}
			
			iters ++;
		}
		
		/**
		 * Allows Entity to follow the player independatly of range and checks collisions.
		 */
		public function followPlayer():void {
			if (y > Maze.getPlayer().y) 
			{
				y -= checkWalkable(0);
			}
			if (x < Maze.getPlayer().x) 
			{
				x += checkWalkable(1);
			}
			if (y < Maze.getPlayer().y) 
			{
				y += checkWalkable(2);
			}
			if (x > Maze.getPlayer().x) 
			{
				x -= checkWalkable(3);
			}
		}
		
		/**
		 * Checks collisions with certain speed and direction. 0 - up 1 - right 2 - down 3 - left
		 */
		public function checkWalkable(dir:int):Number {
			
			switch (dir) 
			{
				case 0:
					pointDir0.x = x;
					pointDir0.y = y - speed;
					pointDir1.x = x + 16;
					pointDir1.y = y - speed;
					if (Maze.getMap().getBlockAt(pointDir0).walkable && (((x % 16) == 0) || Maze.getMap().getBlockAt(pointDir1).walkable)) {
						return speed;
						
					} else {
						
						return y % 16;
					}
				break;
				case 1:
					pointDir0.x = x + 15 + speed;
					pointDir0.y = y;
					pointDir1.x = x + 15 + speed;
					pointDir1.y = y + 16;
					if (Maze.getMap().getBlockAt(pointDir0).walkable && (((y % 16) == 0) || Maze.getMap().getBlockAt(pointDir1).walkable)) {
						return speed;
						
					} else {
						
						return 15 -((x + 15) % 16);
					}
				break;
				case 2:
					pointDir0.x = x;
					pointDir0.y = y + 15 + speed;
					pointDir1.x = x + 16;
					pointDir1.y = y + 15 + speed;
					if (Maze.getMap().getBlockAt(pointDir0).walkable && (((x % 16) == 0) || Maze.getMap().getBlockAt(pointDir1).walkable)) {
						return speed;
						
					} else {
						
						return 15 - ((y + 15) % 16);
					}
				break;
				case 3:
					pointDir0.x = x - speed;
					pointDir0.y = y;
					pointDir1.x = x - speed;
					pointDir1.y = y + 16;
					if (Maze.getMap().getBlockAt(pointDir0).walkable && (((y % 16) == 0) || Maze.getMap().getBlockAt(pointDir1).walkable)) {
						return speed;
						
					} else {
						
						return x % 16;
					}
				break;
			}
			
			return 0;
		}
		
	}

}