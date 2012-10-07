package com.kapelushStudios.MazeMaster 
{
	import com.kapelushStudios.MazeMaster.entities.Player;
	import com.kapelushStudios.MazeMaster.utils.Texture;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class MainView extends Sprite 
	{
		private var mazeMaster:MazeMaster;
		private var multiplier:int = 6;
		private var overlay:Bitmap;
		
		public function MainView() 
		{
			mazeMaster = new MazeMaster();
			addChild(mazeMaster);
			mazeMaster.width *= multiplier;
			mazeMaster.height *= multiplier;
			MazeMaster.getPlayer().setMoveCallback(setPosition);
			setPosition(MazeMaster.getPlayer());
			overlay = Texture.getOverlay();
			overlay.width *= multiplier;
			overlay.height *= multiplier;
			overlay.x = -2000;
			overlay.y = -1500;
			//addChild(overlay);
		}
		public function setPosition(player:Player):void
		{
			mazeMaster.x = 400 - (player.x + 8)*multiplier;
			mazeMaster.y = 300 - (player.y + 12)*multiplier;
		}
	}

}