package com.stirante.MazeMaster.entities
{
	import com.stirante.MazeMaster.map.Map;
	import com.stirante.MazeMaster.MazeMaster;
	import com.stirante.MazeMaster.utils.Control;
	import com.stirante.MazeMaster.utils.Texture;
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
		//private var inventory:Vector.<Item>;
		private var upcorner:Point;
		private var upcorner1:Point;
		private var downcorner:Point;
		private var downcorner1:Point;
		private var leftcorner:Point;
		private var leftcorner1:Point;
		private var rightcorner:Point;
		private var rightcorner1:Point;
		private var world:Map;
		
		public function Player() 
		{
			super(this, Texture.getBlock(9, 10), EntityType.PLAYER, "Player", 1, 1);
			control = new Control(action);
			addChild(control);
			upcorner = new Point();
			upcorner1 = new Point();
			downcorner = new Point();
			downcorner1 = new Point();
			leftcorner = new Point();
			leftcorner1 = new Point();
			rightcorner = new Point();
			rightcorner1 = new Point();
			world = MazeMaster.getMap();
		}
		override public function getMaxHealth():int 
		{
			return 20;
		}
		override public function getType():String 
		{
			return EntityType.PLAYER;
		}
		override protected function killEntity():void 
		{
			super.killEntity();
		}
		public function action(dir:String):void
		{
			if (dir == "up") {
				this.y -= getSpeed();
				upcorner.x = this.x - width / 2;
				upcorner.y = this.y - height / 2;
				upcorner1.x = this.x + width / 2 - 1;
				upcorner1.y = upcorner.y;
				if (world.collideWith(upcorner) || world.collideWith(upcorner1)) {
					this.y += getSpeed();
					world.getBlockAt(upcorner).onEntityWalked(this);
				}
			}
			if (dir == "down") {
				this.y += getSpeed();
				downcorner.x = this.x - width / 2;
				downcorner.y = height / 2 + this.y - 1;
				downcorner1.x = this.x + width / 2 - 1;
				downcorner1.y = downcorner.y;
				if (world.collideWith(downcorner) || world.collideWith(downcorner1)) {
					this.y -= getSpeed();
					world.getBlockAt(downcorner).onEntityWalked(this);
				}
			}
			if (dir == "left") {
				this.x -= getSpeed();
				leftcorner.x = this.x - width / 2;
				leftcorner.y = this.y - height / 2;
				leftcorner1.x = leftcorner.x;
				leftcorner1.y = this.y + height / 2 - 1;
				if (world.collideWith(leftcorner) || world.collideWith(leftcorner1)) {
					this.x += getSpeed();
					world.getBlockAt(leftcorner).onEntityWalked(this);
				}
			}
			if (dir == "right") {
				this.x += getSpeed();
				rightcorner.x = width / 2 + this.x - 1;
				rightcorner.y = height / 2 + this.y - 1;
				rightcorner1.x = rightcorner.x;
				rightcorner1.y = this.y - height / 2;
				if (world.collideWith(rightcorner) || world.collideWith(rightcorner1)) {
					this.x -= getSpeed();
					world.getBlockAt(rightcorner).onEntityWalked(this);
				}
			}
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
			return 1;
		}
	}

}