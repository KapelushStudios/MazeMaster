package com.kapelushStudios.MazeMaster.states 
{
	import com.kapelushStudios.MazeMaster.entities.Player;
	import com.kapelushStudios.MazeMaster.map.Maze;
	import com.kapelushStudios.MazeMaster.utils.Texture;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class GameState extends Sprite 
	{
		private var mazeMaster:Maze;
		private var multiplier:int = 6;
		private var overlay:Bitmap;
		
		public function GameState() 
		{
			mazeMaster = new Maze();
			addChild(mazeMaster);
			mazeMaster.width *= multiplier;
			mazeMaster.height *= multiplier;
			setPosition(Maze.getPlayer());
			overlay = Texture.getOverlay();
			overlay.width *= multiplier;
			overlay.height *= multiplier;
			overlay.x = -2000;
			overlay.y = -1500;
			addChild(overlay);
			Maze.getPlayer().setMoveCallback(setPosition);
		}
		public function setPosition(player:Player):void
		{
			mazeMaster.x = 400 - (player.x + 8)*multiplier;
			mazeMaster.y = 300 - (player.y + 12)*multiplier;
		}
		public function getMaze():Maze
		{
			return mazeMaster;
		}
	}

}