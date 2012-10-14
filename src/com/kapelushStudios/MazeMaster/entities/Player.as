package com.kapelushStudios.MazeMaster.entities
{
	import com.kapelushStudios.MazeMaster.item.Inventory;
	import com.kapelushStudios.MazeMaster.item.Item;
	import com.kapelushStudios.MazeMaster.map.Map;
	import com.kapelushStudios.MazeMaster.map.Maze;
	import com.kapelushStudios.MazeMaster.utils.Control;
	import com.kapelushStudios.MazeMaster.utils.Texture;
	import flash.display.Bitmap;
	import flash.geom.*;
	import flash.system.*;
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Player extends Entity
	{
		private var control:Control;
		private var mana:Number;
		private var inventory:Inventory;
		private var upcorner:Point;
		private var upcorner1:Point;
		private var downcorner:Point;
		private var downcorner1:Point;
		private var leftcorner:Point;
		private var leftcorner1:Point;
		private var rightcorner:Point;
		private var rightcorner1:Point;
		private var world:Map;
		private var moveID:int;
		private var state1:Bitmap;
		private var state2:Bitmap;
		private var state3:Bitmap;
		private var rect:Rectangle = new Rectangle(0, 0, 16, 16);
		private var actualTex:int = 0;
		private var moveCallback:Function;
		private var noCollision:Boolean = true;
		private var xDir:int;
		private var yDir:int;
		private var pointDir0:Point = new Point();
		private var pointDir1:Point = new Point();
		
		public function Player()
		{
			state1 = Texture.getPlayer(1);
			state2 = Texture.getPlayer(2);
			state3 = Texture.getPlayer(3);
			super(this, state3, EntityType.PLAYER, "Player");
			control = new Control(action, idle);
			addChild(control);
			upcorner = new Point();
			upcorner1 = new Point();
			downcorner = new Point();
			downcorner1 = new Point();
			leftcorner = new Point();
			leftcorner1 = new Point();
			rightcorner = new Point();
			rightcorner1 = new Point();
			world = Maze.getMap();
			moveID = Maze.getThread().sheduleRepeatingTask(walkState, 7);
			Maze.getThread().getTask(moveID).setPaused(true);
			inventory = new Inventory();
		}
		
		public function getInventory():Inventory
		{
			return inventory;
		}
		
		public function idle():void
		{
			Maze.getThread().getTask(moveID).setPaused(true);
			setTexture(state3);
			actualTex = 0;
		}
		
		public function walkState():void
		{
			if (actualTex == 0)
			{
				setTexture(state2);
				actualTex = 1;
			}
			else if (actualTex == 1)
			{
				setTexture(state3);
				actualTex = 2;
			}
			else if (actualTex == 2)
			{
				setTexture(state1);
				actualTex = 3;
			}
			else if (actualTex == 3)
			{
				setTexture(state3);
				actualTex = 0;
			}
		}
		
		override public function getMaxHealth():int
		{
			return 5;
		}
		
		override protected function killEntity():void
		{
			super.killEntity();
		}
		
		public function action(dir:String):void
		{
			if (Maze.getThread().getTask(moveID).isPaused())
			{
				Maze.getThread().getTask(moveID).setPaused(false);
			}
			if (dir == "up")
			{
				y -= checkWalkable(0);
				//this.y -= getSpeed();
				//if (!noCollision)
				//{
					//upcorner.x = this.x - 8;
					//upcorner.y = this.y;
					//upcorner1.x = this.x + 7;
					//upcorner1.y = upcorner.y;
					//if (world.collideWith(upcorner) || world.collideWith(upcorner1))
					//{
						//this.y += getSpeed();
					//}
				//}
				//world.getBlockAt(upcorner).onEntityWalked(this);
			}
			if (dir == "down")
			{
				y += checkWalkable(2);
				//this.y += getSpeed();
				//if (!noCollision)
				//{
					//downcorner.x = this.x - 8;
					//downcorner.y = this.y + 16;
					//downcorner1.x = this.x + 7;
					//downcorner1.y = downcorner.y;
					//if (world.collideWith(downcorner) || world.collideWith(downcorner1))
					//{
						//this.y -= getSpeed();
					//}
				//}
				//world.getBlockAt(downcorner).onEntityWalked(this);
			}
			if (dir == "left")
			{
				x -= checkWalkable(3);
				//this.x -= getSpeed();
				//if (!noCollision)
				//{
					//leftcorner.x = this.x - 8;
					//leftcorner.y = this.y + 15;
					//leftcorner1.x = leftcorner.x;
					//leftcorner1.y = this.y + 1;
					//if (world.collideWith(leftcorner) || world.collideWith(leftcorner1))
					//{
						//this.x += getSpeed();
					//}
				//}
				//world.getBlockAt(leftcorner).onEntityWalked(this);
			}
			if (dir == "right")
			{
				x += checkWalkable(1);
				//this.x += getSpeed();
				//if (!noCollision)
				//{
					//rightcorner.x = 7 + this.x;
					//rightcorner.y = this.y + 1;
					//rightcorner1.x = rightcorner.x;
					//rightcorner1.y = this.y + 15;
					//if (world.collideWith(rightcorner) || world.collideWith(rightcorner1))
					//{
						//this.x -= getSpeed();
					//}
				//}
				//world.getBlockAt(rightcorner).onEntityWalked(this);
			}
			if (moveCallback != null)
			{
				moveCallback(this);
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
					pointDir0.y = y - getSpeed() + 8;
					pointDir1.x = x + 16;
					pointDir1.y = y - getSpeed() + 8;
					if (Maze.getMap().getBlockAt(pointDir0).walkable && (((x % 16) == 0) || Maze.getMap().getBlockAt(pointDir1).walkable)) {
						return getSpeed();
						
					} else {
						
						return (y + 8) % 16;
					}
				break;
				case 1:
					pointDir0.x = x + 15 + getSpeed();
					pointDir0.y = y + 8;
					pointDir1.x = x + 15 + getSpeed();
					pointDir1.y = y + 16 + 8;
					if (Maze.getMap().getBlockAt(pointDir0).walkable && ((((y + 8) % 16) == 0) || Maze.getMap().getBlockAt(pointDir1).walkable)) {
						return getSpeed();
						
					} else {
						
						return 15 -((x + 15) % 16);
					}
				break;
				case 2:
					pointDir0.x = x;
					pointDir0.y = y + 15 + getSpeed() + 8;
					pointDir1.x = x + 16;
					pointDir1.y = y + 15 + getSpeed() + 8;
					if (Maze.getMap().getBlockAt(pointDir0).walkable && (((x % 16) == 0) || Maze.getMap().getBlockAt(pointDir1).walkable)) {
						return getSpeed();
						
					} else {
						
						return 15 - ((y + 15 + 8) % 16);
					}
				break;
				case 3:
					pointDir0.x = x - getSpeed();
					pointDir0.y = y + 8;
					pointDir1.x = x - getSpeed();
					pointDir1.y = y + 16 + 8;
					if (Maze.getMap().getBlockAt(pointDir0).walkable && ((((y + 8) % 16) == 0) || Maze.getMap().getBlockAt(pointDir1).walkable)) {
						return getSpeed();
						
					} else {
						
						return x % 16;
					}
				break;
			}
			
			return 0;
		}
		
		public function getMaxMana():int
		{
			return 100;
		}
		
		public function getMana():Number
		{
			return mana;
		}
		
		override public function getSpeed():Number
		{
			return 5;
		}
		
		public function setMoveCallback(method:Function):void
		{
			moveCallback = method;
		}
	}

}