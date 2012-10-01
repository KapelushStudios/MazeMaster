package com.kapelushStudios.MazeMaster.utils
{
	import flash.display.*;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Piotr Brzozowski
	 */
	public class Texture 
	{
		[Embed(source="../../../../resources/textures.png")]
		public static var textury:Class;
		
		[Embed(source = "../../../../resources/Player.png")]
		public static var player1:Class;
		
		[Embed(source = "../../../../resources/Player2.png")]
		public static var player2:Class;
		
		public static function getBlock(x:int, y:int):Bitmap {
			var textures:Bitmap = new textury() as Bitmap;
			var result:Bitmap = new Bitmap(new BitmapData(16, 16, false, 0));
			result.bitmapData.copyPixels(textures.bitmapData, new Rectangle(x * 16, y * 16, 16, 16), new Point(0, 0));
			return result;
		}
		public static function getPlayer(state:int):Bitmap
		{
			var textura:Bitmap;
			if (state == 1){
				textura = new player1() as Bitmap;
			}
			else {
				textura = new player2() as Bitmap;
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
		//public static function getAnimation(x:int, y:int, frames:int):Animation
		//{
			//var textures1:Bitmap = new textury() as Bitmap;
			//var textures:Bitmap = new Bitmap(new BitmapData(16 * frames, 16, false));
			//textures.bitmapData.copyPixels(textures1.bitmapData, new Rectangle(x * 16, y * 16, 16 * frames, 16), new Point());
			//var animation:Animation = new Animation(textures, frames);
			//return animation;
		//}
		
	}

}