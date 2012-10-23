package com.kapelushStudios.MazeMaster.particles
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Particle extends Sprite
	{
		private var texture:DisplayObject;
		private var direction:int;
		private var velocity:Number;
		private var lifeLength:int;
		private var dead:Boolean;
		private var age:int = 0;
		private static var availableParticles:int = 0;
		private static var particles:Vector.<Particle>;
		private var friction:Number;
		
		protected function Particle(texture:DisplayObject, direction:int, velocity:Number, lifeLength:int, friction:Number)
		{
			this.friction = friction;
			this.lifeLength = lifeLength;
			this.velocity = velocity;
			this.direction = direction;
			this.texture = texture;
			addEventListener(Event.ENTER_FRAME, enterFrame);
			addChild(this.texture);
			this.rotation = direction;
		}
		
		public function randomDirection():void
		{
			direction = (int)(Math.random() * 360);
			this.rotation = direction;
		}
		
		public function randomSpeed(min:Number, max:Number):void
		{
			velocity = (Math.random() * (max - min)) + min;
		}
		
		public function randomSize(min:Number, max:Number):void
		{
			var size:Number = (Math.random() * (max - min)) + min;
			this.width *= size;
			this.height *= size;
		}
		
		private function enterFrame(e:Event):void
		{
			age++;
			if (age == lifeLength)
			{
				setDead(true);
				return ;
			}
			
			velocity *= friction;
			
			var speedx:Number =Math.sin(direction*(Math.PI/180))*2;
			var speedy:Number = Math.cos(direction*(Math.PI/180))*2*-1;
			
			this.x += speedx * velocity;
			this.y += speedy * velocity;
			
			this.alpha = 1 - (lifeLength / age);
		}
		
		public function setDead(value:Boolean):void
		{
			if (dead != value)
			{
				dead = value;
				if (value)
				{
					availableParticles++;
					removeEventListener(Event.ENTER_FRAME, enterFrame);
					removeChild(texture);
				}
				else
				{
					availableParticles--;
					addEventListener(Event.ENTER_FRAME, enterFrame);
					age = 0;
				}
				Particles.notifyState(this);
			}
		}
		
		public function setData(texture:DisplayObject, direction:int, velocity:Number, lifeLength:int, friction:Number):void
		{
			if (friction != null)
				this.friction = friction;
			if (lifeLength != null)
				this.lifeLength = lifeLength;
			if (velocity != null)
				this.velocity = velocity;
			if (direction != null)
				this.direction = direction;
			if (texture != null){
				this.texture = texture;
				addChild(this.texture);
			}
			setDead(false);
		}
		
		public function isDead():Boolean
		{
			return dead;
		}
		
		public static function addParticle(texture:DisplayObject, direction:int, velocity:Number, lifeLength:int, friction:Number = 1):Particle
		{
			if (particles == null) {
				particles = new Vector.<Particle>();
			}
			if (availableParticles == 0) {
				return particles[particles.push(new Particle(texture, direction, velocity, lifeLength, friction:Number))];
			}
			else {
				for (var i:int = 0; i < particles.length; i++) 
				{
					if (particles[i].isDead()) {
						particles[i].setData(texture, direction, velocity, lifeLength);
						return particles[i];
					}
				}
				return particles[particles.push(new Particle(texture, direction, velocity, lifeLength, friction))];
			}
		}
	
	}

}