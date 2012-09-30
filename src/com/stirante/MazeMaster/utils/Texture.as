package com.stirante.MazeMaster.utils
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
		
		public static function getBlock(x:int, y:int):Bitmap {
			var textures:Bitmap = new textury() as Bitmap;
			var result:Bitmap = new Bitmap(new BitmapData(16, 16, false, 0));
			result.bitmapData.copyPixels(textures.bitmapData, new Rectangle(x * 16, y * 16, 16, 16), new Point(0, 0));
			return result;
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