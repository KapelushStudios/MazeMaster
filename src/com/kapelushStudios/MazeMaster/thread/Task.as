package com.kapelushStudios.MazeMaster.thread 
{
	import com.kapelushStudios.MazeMaster.MazeMaster;
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Task 
	{
		private var method:Function;
		private var interval:int;
		private var id:int;
		private var ticks:int = 0;
		private var repeated:int = 0;
		private var repeat:int;
		private var paused:Boolean;
		private var args:Array;
		
		public function Task(method:Function, interval:int, repeat:int, id:int, args:Array = null) 
		{
			this.repeat = repeat;
			this.id = id;
			this.interval = interval;
			this.method = method;
			this.args = args;
		}
		
		public function run():void
		{
			ticks++;
			if (ticks == interval) {
				ticks = 0;
				method.apply(null, args);
				if (repeat != 0) 
				{
					repeated++;
					if (repeated == repeat) 
					{
						MazeMaster.getThread().cancelTask(id);
					}
				}
				if (repeat == -1)
				{
					MazeMaster.getThread().cancelTask(id);
				}
			}
		}
		
		public function getId():int
		{
			return id;
		}
		
		public function isPaused():Boolean
		{
			return paused;
		}
		public function setPaused(state:Boolean):void
		{
			paused = state;
		}
		public function getArgs():Array
		{
			return args;
		}
		public function setArgs(...rest:Array):void
		{
			args = rest;
		}
	}

}