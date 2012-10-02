package com.kapelushStudios.MazeMaster 
{
	import com.kapelushStudios.MazeMaster.entities.Player;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class MainView extends Sprite 
	{
		private var mazeMaster:MazeMaster;
		private var multiplier:int = 6;
		
		public function MainView() 
		{
			mazeMaster = new MazeMaster();
			addChild(mazeMaster);
			mazeMaster.width *= multiplier;
			mazeMaster.height *= multiplier;
			MazeMaster.getPlayer().setMoveCallback(setPosition)
			setPosition(MazeMaster.getPlayer());
		}
		public function setPosition(player:Player):void
		{
			mazeMaster.x = 400 - (player.x+player.width/2)*multiplier;
			mazeMaster.y = 300 - (player.y+player.height/2)*multiplier;
		}
	}

}