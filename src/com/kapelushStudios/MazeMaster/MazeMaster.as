package com.kapelushStudios.MazeMaster
{
	import com.kapelushStudios.MazeMaster.blocks.BlockList;
	import com.kapelushStudios.MazeMaster.entities.Enemy;
	import com.kapelushStudios.MazeMaster.entities.Player;
	import com.kapelushStudios.MazeMaster.map.Map;
	import com.kapelushStudios.MazeMaster.map.MazeGen;
	import com.kapelushStudios.MazeMaster.thread.Thread;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class MazeMaster extends Sprite 
	{	
		private static var thread:Thread;
		private static var instance:MazeMaster;
		private static var map:Map;
		private static var player:Player;//192, 32
		public function MazeMaster():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			BlockList.init();
			instance = this;
			thread = new Thread();
			addEventListener(Event.ENTER_FRAME, thread.run);
			map = new Map(MazeGen.generateMaze(41, 41));
			player = new Player();
			player.x = 16;
			player.y = 16;
			//var enemy:Enemy = new Enemy();
			//enemy.x = 192;
			//enemy.y = 16;
			map.spawnEntity(player);
			//map.spawnEntity(enemy);
			addChild(map);
		}
		
		//private function enterFrame(e:Event):void 
		//{
			//thread.run(e);
		//}
		
		public static function getThread():Thread
		{
			return thread;
		}
		
		public static function getInstance():MazeMaster
		{
			return instance;
		}
		
		public static function getMap():Map
		{
			return map;
		}
		public static function getPlayer():Player
		{
			return player;
		}
	}
	
}