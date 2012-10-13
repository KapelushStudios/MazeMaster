package com.kapelushStudios.MazeMaster.states 
{
	import com.kapelushStudios.MazeMaster.entities.Player;
	import com.kapelushStudios.MazeMaster.map.Maze;
	import com.kapelushStudios.MazeMaster.MazeMaster;
	import com.kapelushStudios.MazeMaster.utils.State;
	import com.kapelushStudios.MazeMaster.utils.Texture;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.system.fscommand;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class GameState extends Sprite 
	{
		private var mazeMaster:Maze;
		private var multiplier:int = 1;
		private var overlay:Bitmap;
		
		public function GameState() 
		{
			mazeMaster = new Maze();
			addChild(mazeMaster);
			mazeMaster.width *= multiplier;
			mazeMaster.height *= multiplier;
			setPosition(Maze.getPlayer());
			overlay = Texture.getOverlay();
			//overlay.width = 800;
			//overlay.height = 600;
			overlay.width *= multiplier;
			overlay.height *= multiplier;
			overlay.x = -2000;
			overlay.y = -1500;
			//addChild(overlay);
			Maze.getPlayer().setMoveCallback(setPosition);
			MazeMaster.addKeyDownCallback(keyDown);
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.ESCAPE) {
				MazeMaster.getInstance().setState(State.MENU);
				fscommand("fullscreen", "true");
			}
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