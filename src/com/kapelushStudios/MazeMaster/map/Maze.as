package com.kapelushStudios.MazeMaster.map
{
	import com.kapelushStudios.MazeMaster.blocks.BlockList;
	import com.kapelushStudios.MazeMaster.entities.Enemy;
	import com.kapelushStudios.MazeMaster.entities.Player;
	import com.kapelushStudios.MazeMaster.item.Items;
	import com.kapelushStudios.MazeMaster.thread.Thread;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Maze extends Sprite 
	{	
		private static var thread:Thread;
		private static var instance:Maze;
		private static var map:Map;
		private static var player:Player;
		private var enemy:Enemy;
		public function Maze():void 
		{
			init();
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			BlockList.init();
			Items.init();
			instance = this;
			thread = new Thread();
			addEventListener(Event.ENTER_FRAME, enterFrame);
			map = new Map(MazeGen.generateMaze(31, 3));
			player = new Player();
			player.x = 16 * MazeGen.thick;
			player.y = (16 * MazeGen.thick) - 8;
			map.spawnEntity(player);
			addChild(map);
			//enemy = new Enemy();
			//enemy.x = 48;
			//enemy.y = 21 * 16;
			//map.spawnEntity(enemy);
		}
		
		private function enterFrame(e:Event):void 
		{
			thread.run(e);
		}
		
		public static function getThread():Thread
		{
			return thread;
		}
		
		public static function getInstance():Maze
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
		
		public function run():void 
		{
			enterFrame(null);
		}
	}
	
}