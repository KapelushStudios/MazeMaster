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
		
		private function enterFrame(e:Event):void
		{
			age++;
			if (age == lifeLength)
			{
				setDead(true);
				return ;
			}
			
			velocity *= friction;
			
			var speedx:Number =Math.sin(this.rotation*(Math.PI/180))*2;
			var speedy:Number = Math.cos(this.rotation*(Math.PI/180))*2*-1;
			
			this.x += speedx * velocity;
			this.y += speedy * velocity;
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
			this.friction = friction;
			this.lifeLength = lifeLength;
			this.velocity = velocity;
			this.direction = direction;
			this.texture = texture;
			addChild(this.texture);
			setDead(false);
		}
		
		public function isDead():Boolean
		{
			return dead;
		}
		
		public static function addParticle(texture:DisplayObject, direction:int, velocity:Number, lifeLength:int, friction:Number):Particle
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
				return particles[particles.push(new Particle(texture, direction, velocity, lifeLength, friction:Number))];
			}
		}
	
	}

}