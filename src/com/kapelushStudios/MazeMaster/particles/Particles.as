package com.kapelushStudios.MazeMaster.particles 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Particles extends Sprite
	{
		private static var instance:Particles;
		
		public function Particles() 
		{
			instance = this;
		}
		
		public static function notifyState(particle:Particle):void
		{
			if (particle.isDead()) {
				instance.removeChild(particle);
			}
			else {
				instance.addChild(particle);
			}
		}
		
		public static function getInstance():Particles
		{
			return instance;
		}
		
	}

}