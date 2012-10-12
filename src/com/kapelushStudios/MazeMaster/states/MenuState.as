package com.kapelushStudios.MazeMaster.states 
{
	import com.kapelushStudios.MazeMaster.MazeMaster;
	import com.kapelushStudios.MazeMaster.utils.State;
	import com.kapelushStudios.MazeMaster.utils.Texture;
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class MenuState extends Sprite
	{
		private var main:Bitmap;
		private var exitButton:SimpleButton;
		private var startButton:SimpleButton;
		private var optionsButton:SimpleButton;
		private var multiplier:int = 4;
		
		public function MenuState() 
		{
			main = Texture.getMainMenu();
			exitButton = new SimpleButton(Texture.getButton(State.EXIT, 0), Texture.getButton(State.EXIT, 1), Texture.getButton(State.EXIT, 2), Texture.getButton(State.EXIT, 2));
			startButton = new SimpleButton(Texture.getButton(State.GAME, 0), Texture.getButton(State.GAME, 1), Texture.getButton(State.GAME, 2), Texture.getButton(State.GAME, 2));
			optionsButton = new SimpleButton(Texture.getButton(State.OPTIONS, 0), Texture.getButton(State.OPTIONS, 1), Texture.getButton(State.OPTIONS, 2), Texture.getButton(State.OPTIONS, 2));
			main.width *= multiplier;
			startButton.width *= multiplier;
			exitButton.width *= multiplier;
			optionsButton.width *= multiplier;
			main.height *= multiplier;
			startButton.height *= multiplier;
			exitButton.height *= multiplier;
			optionsButton.height *= multiplier;
			
			exitButton.x = 143 * multiplier;
			startButton.x = 60 * multiplier;
			optionsButton.x = 25 * multiplier;
			exitButton.y = 115 * multiplier;
			startButton.y = 115 * multiplier;
			optionsButton.y = 115 * multiplier;
			
			addChild(main);
			addChild(optionsButton);
			addChild(startButton);
			addChild(exitButton);
			
			startButton.addEventListener(MouseEvent.CLICK, startButton_click);
		}
		
		private function startButton_click(e:MouseEvent):void 
		{
			MazeMaster.getInstance().setState(State.GAME);
		}
		
	}

}