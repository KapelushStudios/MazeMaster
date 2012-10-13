package com.kapelushStudios.MazeMaster.utils
{
	import com.kapelushStudios.MazeMaster.entities.EntityType;
	import flash.display.*;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest; //31, 31, 8
	
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Texture
	{
		[Embed(source="../../../../resources/blocks/textures.png")]
		public static var textury:Class;
		
		[Embed(source="../../../../resources/entities/Player.png")]
		public static var player1:Class;
		
		[Embed(source="../../../../resources/entities/Player1.png")]
		public static var player3:Class;
		
		[Embed(source="../../../../resources/entities/Player2.png")]
		public static var player2:Class;
		
		[Embed(source="../../../../resources/entities/Light.png")]
		public static var overlay:Class;
		
		[Embed(source="../../../../resources/gui/menu/option0.png")]
		public static var option0:Class;
		
		[Embed(source="../../../../resources/gui/menu/SettingsAnimation.png")]
		public static var option1:Class;
		
		[Embed(source="../../../../resources/gui/menu/option2.png")]
		public static var option2:Class;
		
		[Embed(source="../../../../resources/gui/menu/start0.png")]
		public static var start0:Class;
		
		[Embed(source="../../../../resources/gui/menu/StartAnimations.png")]
		public static var start1:Class;
		
		[Embed(source="../../../../resources/gui/menu/start2.png")]
		public static var start2:Class;
		
		[Embed(source="../../../../resources/gui/menu/logoff0.png")]
		public static var logoff0:Class;
		
		[Embed(source="../../../../resources/gui/menu/LogOffAnimation.png")]
		public static var logoff1:Class;
		
		[Embed(source="../../../../resources/gui/menu/logoff2.png")]
		public static var logoff2:Class;
		
		[Embed(source="../../../../resources/gui/menu/MainMenu.png")]
		public static var menu:Class;
		
		[Embed(source="../../../../resources/gui/cursor.png")]
		public static var cursor:Class;
		
		public static function getBlock(x:int, y:int):Bitmap
		{
			var textures:Bitmap = new textury() as Bitmap;
			var result:Bitmap = new Bitmap(new BitmapData(16, 16, false, 0));
			result.bitmapData.copyPixels(textures.bitmapData, new Rectangle(x * 16, y * 16, 16, 16), new Point(0, 0));
			return result;
		}
		
		public static function getPlayer(state:int):Bitmap
		{
			var textura:Bitmap;
			if (state == 1)
			{
				textura = new player1() as Bitmap;
			}
			else if (state == 2)
			{
				textura = new player2() as Bitmap;
			}
			else
			{
				textura = new player3() as Bitmap;
			}
			
			for (var i:int = 0; i < Math.round(textura.width); i++)
			{
				for (var j:int = 0; j < Math.round(textura.height); j++)
				{
					if (textura.bitmapData.getPixel(i, j) == 0xCC22BB)
					{
						textura.bitmapData.setPixel32(i, j, 0x00FFFFFF);
					}
				}
			}
			return textura;
		}
		
		public static function getOverlay():Bitmap
		{
			return new overlay() as Bitmap;
		}
		
		public static function getButton(type:State, state:int):DisplayObject
		{
			switch (type)
			{
				case State.OPTIONS: 
					if (state == 0)
					{
						var textura:Bitmap = new option0() as Bitmap;
						
						for (var i:int = 0; i < Math.round(textura.width); i++)
						{
							for (var j:int = 0; j < Math.round(textura.height); j++)
							{
								if (textura.bitmapData.getPixel(i, j) == 0xCC22BB)
								{
									textura.bitmapData.setPixel32(i, j, 0x00FFFFFF);
								}
							}
						}
						return textura;
					}
					else if (state == 1)
					{
						textura = new option1() as Bitmap;
						
						for (i = 0; i < Math.round(textura.width); i++)
						{
							for (j = 0; j < Math.round(textura.height); j++)
							{
								if (textura.bitmapData.getPixel(i, j) == 0xCC22BB)
								{
									textura.bitmapData.setPixel32(i, j, 0x00FFFFFF);
								}
							}
						}
						return getAnimation(textura, 0, 0, 32, 32, 9, 8);
					}
					else if (state == 2)
					{
						textura = new option2() as Bitmap;
						
						for (i = 0; i < Math.round(textura.width); i++)
						{
							for (j = 0; j < Math.round(textura.height); j++)
							{
								if (textura.bitmapData.getPixel(i, j) == 0xCC22BB)
								{
									textura.bitmapData.setPixel32(i, j, 0x00FFFFFF);
								}
							}
						}
						return textura;
					}
					break;
				case State.GAME: 
					if (state == 0)
					{
						textura = new start0() as Bitmap;
						
						for (i = 0; i < Math.round(textura.width); i++)
						{
							for (j = 0; j < Math.round(textura.height); j++)
							{
								if (textura.bitmapData.getPixel(i, j) == 0xCC22BB)
								{
									textura.bitmapData.setPixel32(i, j, 0x00FFFFFF);
								}
							}
						}
						return textura;
					}
					else if (state == 1)
					{
						textura = new start1() as Bitmap;
						
						for (i = 0; i < Math.round(textura.width); i++)
						{
							for (j = 0; j < Math.round(textura.height); j++)
							{
								if (textura.bitmapData.getPixel(i, j) == 0xCC22BB)
								{
									textura.bitmapData.setPixel32(i, j, 0x00FFFFFF);
								}
							}
						}
						return getAnimation(textura, 0, 0, 80, 32, 16, 8);
					}
					else if (state == 2)
					{
						textura = new start2() as Bitmap;
						
						for (i = 0; i < Math.round(textura.width); i++)
						{
							for (j = 0; j < Math.round(textura.height); j++)
							{
								if (textura.bitmapData.getPixel(i, j) == 0xCC22BB)
								{
									textura.bitmapData.setPixel32(i, j, 0x00FFFFFF);
								}
							}
						}
						return textura;
					}
					break;
				case State.EXIT: 
					if (state == 0)
					{
						textura = new logoff0() as Bitmap;
						
						for (i = 0; i < Math.round(textura.width); i++)
						{
							for (j = 0; j < Math.round(textura.height); j++)
							{
								if (textura.bitmapData.getPixel(i, j) == 0xCC22BB)
								{
									textura.bitmapData.setPixel32(i, j, 0x00FFFFFF);
								}
							}
						}
						return textura;
					}
					else if (state == 1)
					{
						textura = new logoff1() as Bitmap;
						
						for (i = 0; i < Math.round(textura.width); i++)
						{
							for (j = 0; j < Math.round(textura.height); j++)
							{
								if (textura.bitmapData.getPixel(i, j) == 0xCC22BB)
								{
									textura.bitmapData.setPixel32(i, j, 0x00FFFFFF);
								}
							}
						}
						return getAnimation(textura, 0, 0, 32, 32, 9, 8);
					}
					else if (state == 2)
					{
						textura = new logoff2() as Bitmap;
						
						for (i = 0; i < Math.round(textura.width); i++)
						{
							for (j = 0; j < Math.round(textura.height); j++)
							{
								if (textura.bitmapData.getPixel(i, j) == 0xCC22BB)
								{
									textura.bitmapData.setPixel32(i, j, 0x00FFFFFF);
								}
							}
						}
						return textura;
					}
					break;
			}
			return null;
		}
		
		public static function getMainMenu():Bitmap
		{
			return new menu() as Bitmap;
		}
		
		public static function getCursor():Bitmap
		{
			var textura:Bitmap = new cursor() as Bitmap;
			
			for (var i:int = 0; i < Math.round(textura.width); i++)
			{
				for (var j:int = 0; j < Math.round(textura.height); j++)
				{
					if (textura.bitmapData.getPixel(i, j) == 0xCC22BB)
					{
						textura.bitmapData.setPixel32(i, j, 0x00FFFFFF);
					}
				}
			}
			return textura;
		}
		
		public static function getAnimation(textures:Bitmap, x:int, y:int, width:int, height:int, frameNum:int, speed:int, repeatOnce:Boolean = true):Animation
		{
			var result:Bitmap = new Bitmap(new BitmapData(width * frameNum, height, true, 0));
			result.bitmapData.copyPixels(textures.bitmapData, new Rectangle(x, y, width * frameNum, height), new Point(0, 0));
			
			var animation:Animation = new Animation(result, speed, frameNum, width, height, repeatOnce);
			
			return animation;
		}
		
		static public function getEntity(type:EntityType):Bitmap
		{
			switch (type)
			{
				case EntityType.BAT: 
					return getBlock(3, 3);
					break;
			}
			return null;
		}
	
	}

}