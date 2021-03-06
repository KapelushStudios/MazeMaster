package com.kapelushStudios.MazeMaster.entities
{
	import com.kapelushStudios.MazeMaster.map.Maze;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Entity extends Sprite
	{
		public static var ids:int = 0;
		protected var texture:Bitmap;
		protected var type:EntityType;
		protected var _name:String;
		public var id:int;
		protected var health:int;
		protected var speed:Number;
		
		public function Entity(self:Entity ,texture:Bitmap, type:EntityType, name:String) 
		{
			if (self != this) 
			{
				throw IllegalOperationError("Abstract type!");
			}
			id = ids;
			ids++;
			this.texture = texture;
			addChild(this.texture);
		}
		
		
		
		public function getType():EntityType 
		{
			return type;
		}
		public function getName():String 
		{
			return _name;
		}
		
		public function getMaxHealth():int
		{
			throw IllegalOperationError("Method getType must be overriden");
			return 0;
		}
		
		public function setHealth(val:int):void
		{
			health = val;
			if (isDead())
			{
				killEntity();
			}
		}
		
		protected function killEntity():void
		{
			//Maze.getInstance().onEntityKilled(this);
		}
		
		public function getHealth():int
		{
			return health;
		}
		
		public function heal(val:int):void
		{
			if (getHealth() + val > getMaxHealth())
			{
				setHealth(getMaxHealth());
			}
			else
			{
				setHealth(getHealth() + val);
			}
		}
		
		public function isDead():Boolean
		{
			if (getHealth() <= 0)
			{
				return true;
			}
			return false;
		}
		
		public function attack(val:Number):void
		{
			setHealth(getHealth() - val);
		}
		
		public function getSpeed():Number
		{
			return speed;
		}
		
		public function setSpeed(val:Number):void
		{
			speed = val;
		}
		
		public function prepareToSpawn():void
		{
			setHealth(getMaxHealth());
		}
		public function clone():Entity
		{
			return new Entity(this, texture, type, name);
		}
		public function getTexture():Bitmap
		{
			return texture;
		}
		public function setTexture(tex:Bitmap):void
		{
			removeChild(texture);
			texture = tex;
			addChild(texture);
		}
	}

}