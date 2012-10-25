package com.kapelushStudios.MazeMaster.particles
{
	import com.kapelushStudios.MazeMaster.entities.Action;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
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
		private var speed:Number;
		private var lifeLength:int;
		private var dead:Boolean;
		private var age:int = 0;
		private static var availableParticles:int = 0;
		private static var particles:Vector.<Particle>;
		private var friction:Number;
		private static var allowConstructor:Boolean = false;
		private var spin:int = 0;
		
		public function Particle(texture:DisplayObject = null, direction:int = -1, speed:Number = -1, lifeLength:int = -1, friction:Number = -1)
		{
			if (!allowConstructor)
				throw new Error("Cannot create particle! Use Particle.addParticle()");
			
			if (friction != -1)
				this.friction = friction;
			if (lifeLength != -1)
				this.lifeLength = lifeLength;
			if (speed != -1)
				this.speed = speed;
			if (direction != -1)
				this.direction = direction;
			if (texture != null){
				this.texture = texture;
				addChild(this.texture);
			}
			else {
				texture = new Bitmap();
			}
			addEventListener(Event.ENTER_FRAME, enterFrame);
			this.rotation = direction;
			Particles.notifyState(this);
		}
		
		public function randomAngle(min:int = 0, max:int = 360):void
		{
			direction = (int)(Math.random() * (max - min)) + min;
			this.rotation = direction;
		}
		
		public function setBitmapData(bd:BitmapData):void
		{
			if (texture == null && !(texture is Bitmap))
				texture = new Bitmap(bd);
			else 
				(Bitmap)(texture).bitmapData = bd;
			addChild(texture);
		}
		
		public function randomDirectionAngle(dir:Action):void
		{
			var max:int = 0;
			var min:int = 360;
			if (dir == Action.DOWN) {
				max = 45;
				min = -45;
			}
			if (dir == Action.LEFT) {
				max = 135;
				min = 45;
			}
			if (dir == Action.UP) {
				max = 225;
				min = 135;
			}
			if (dir == Action.RIGHT) {
				max = 315;
				min = 225;
			}
			direction = (int)(Math.random() * (max - min)) + min;
			this.rotation = direction;
		}
		
		public function randomSpeed(min:Number, max:Number):void
		{
			speed = (Math.random() * (max - min)) + min;
		}
		
		private function enterFrame(e:Event):void
		{
			age++;
			if (age == lifeLength)
			{
				setDead(true);
				return ;
			}
			
			speed *= friction;
			
			var speedx:Number = Math.sin(direction * (Math.PI / 180)) * 2;
			var speedy:Number = Math.cos(direction * (Math.PI / 180)) * 2 * -1;
			
			this.x += speedx * speed;
			this.y += speedy * speed;
			
			this.alpha = 1 - (age / lifeLength);
			
			this.rotation += spin;
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
		
		public function setData(texture:DisplayObject = null, direction:int = -1, speed:Number = -1, lifeLength:int = -1, friction:Number = -1):void
		{
			if (friction != -1)
				this.friction = friction;
			if (lifeLength != -1)
				this.lifeLength = lifeLength;
			if (speed != -1)
				this.speed = speed;
			if (direction != -1)
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
		
		public static function addParticle(texture:DisplayObject, direction:int, speed:Number, lifeLength:int, friction:Number = 1):Particle
		{
			if (particles == null) {
				particles = new Vector.<Particle>();
			}
			if (availableParticles == 0) {
				allowConstructor = true;
				var id:int = particles.push(new Particle(texture, direction, speed, lifeLength, friction));
				//trace(particles.length);
				allowConstructor = false;
				return particles[id-1];
			}
			else {
				for (var i:int = 0; i < particles.length; i++) 
				{
					if (particles[i].isDead()) {
						particles[i].setData(texture, direction, speed, lifeLength, friction);
						return particles[i];
					}
				}
				allowConstructor = true;
				return particles[particles.push(new Particle(texture, direction, speed, lifeLength, friction))];
				allowConstructor = false;
				//trace(particles.length);
			}
		}
		
		public function setSpinnig(value:Boolean):void 
		{
			if (value)
				spin = Math.round(Math.random() * 4 - 1) - 2;
			else 
				spin = 0;
		}
	}

}