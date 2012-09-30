package com.kapelushStudios.MazeMaster.entities
{
	import com.kapelushStudios.MazeMaster.MazeMaster;
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
		private var texture:Bitmap;
		private var type:EntityType;
		private var _name:String;
		public var id:int;
		private var posX:int;
		private var posY:int;
		private var health:int;
		private var speed:Number;
		
		public function Entity(self:Entity ,texture:Bitmap, type:EntityType, name:String, posX:int, posY:int) 
		{
			if (self != this) 
			{
				throw IllegalOperationError("Abstract type!");
			}
			this.posY = posY;
			this.posX = posX;
			id = ids;
			ids++;
			this.texture = texture;
			addChild(this.texture);
		}
		public function getType():EntityType 
		{
			throw IllegalOperationError("Method getType must be overriden");
			return null;
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
			//MazeMaster.getInstance().onEntityKilled(this);
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
			return new Entity(this, texture, type, name, posX, posY);
		}
	}

}