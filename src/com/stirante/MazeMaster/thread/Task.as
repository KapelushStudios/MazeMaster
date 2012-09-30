package com.stirante.MazeMaster.thread 
{
	import com.stirante.MazeMaster.MazeMaster;
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
		
		public function Task(method:Function, interval:int, repeat:int, id:int) 
		{
			this.repeat = repeat;
			this.id = id;
			this.interval = interval;
			this.method = method;
			
		}
		
		public function run():void
		{
			ticks++;
			if (ticks == interval) {
				ticks = 0;
				method.call();
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
		
	}

}