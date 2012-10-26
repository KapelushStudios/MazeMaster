package com.kapelushStudios.MazeMaster.shaders
{
	import flash.display.*;
	import flash.filters.*;
	
	/**
	 * Zwraca filtry z zakotwicznonych shader'ów
	 * @author Piotr Brzozowski
	 */
	public class ShaderFilters
	{
		[Embed(source="../../../../../bin/shader/spotlight.pbj",mimeType="application/octet-stream")]
		private static var spotlightShader:Class;
		
		[Embed(source="../../../../../bin/shader/vignette.pbj",mimeType="application/octet-stream")]
		private static var vignetteShader:Class;
		
		[Embed(source="../../../../../bin/shader/sharpen.pbj",mimeType="application/octet-stream")]
		private static var sharpenShader:Class;
		
		[Embed(source="../../../../../bin/shader/posterizer.pbj",mimeType="application/octet-stream")]
		private static var posterizeShader:Class;
		
		[Embed(source="../../../../../bin/shader/sepia.pbj",mimeType="application/octet-stream")]
		private static var sepiaShader:Class;
		
		[Embed(source="../../../../../bin/shader/fisheye.pbj",mimeType="application/octet-stream")]
		private static var fishEyeShader:Class;
		
		[Embed(source="../../../../../bin/shader/ZoomBlur.pbj",mimeType="application/octet-stream")]
		private static var zoomBlurShader:Class;
		
		[Embed(source="../../../../../bin/shader/MotionBlur.pbj",mimeType="application/octet-stream")]
		private static var motionBlurShader:Class;
		
		static private var shader:Shader;
		static private var shaderfilter:ShaderFilter;
		
		public function ShaderFilters()
		{
		
		}
		
		public static function getSpotlightFilter(pos:Array, spotColor:Array, ambientColor:Array, intensity:Number = 15, angle:Number = 240, azimuth:Number = 20, coneAngle:Number = 2, distance:Number = 10):ShaderFilter
		{
			shader = new Shader();
			shader.byteCode = new spotlightShader();
			shader.data.intensity.value = [intensity];
			shader.data.angle.value = [angle];
			shader.data.azimuth.value = [azimuth];
			shader.data.coneAngle.value = [coneAngle];
			shader.data.distance.value = [distance];
			shader.data.position.value = pos;
			shader.data.spotColor.value = spotColor;
			shader.data.ambientColor.value = ambientColor;
			shaderfilter = new ShaderFilter(shader);
			return shaderfilter;
		}
		
		public static function getVignetteFilter(bitmap:Bitmap, amount:Number = 0.5, radius:Number = 1):ShaderFilter
		{
			shader = new Shader();
			shader.byteCode = new vignetteShader();
			shader.data.amount.value = [amount];
			shader.data.radius.value = [radius];
			shader.data.size.value = [bitmap.width, bitmap.height];
			shaderfilter = new ShaderFilter(shader);
			return shaderfilter;
		}
		
		public static function getSharpenFilter(amount:Number = 1, radius:Number = 0.1):ShaderFilter
		{
			shader = new Shader();
			shader.byteCode = new sharpenShader();
			shader.data.amount.value = [amount];
			shader.data.radius.value = [radius];
			shaderfilter = new ShaderFilter(shader);
			return shaderfilter;
		}
		
		public static function getPosterizeFilter():ShaderFilter
		{
			shader = new Shader();
			shader.byteCode = new posterizeShader();
			shaderfilter = new ShaderFilter(shader);
			return shaderfilter;
		}
		
		public static function getSepiaFilter(crossfade:Number = 0.7):ShaderFilter
		{
			shader = new Shader();
			shader.byteCode = new sepiaShader();
			shader.data.crossfade.value = [crossfade];
			shaderfilter = new ShaderFilter(shader);
			return shaderfilter;
		}
		
		public static function getFishEyeFilter(center_x:Number = 0, center_y:Number = 0, radius:Number = 200):ShaderFilter
		{
			shader = new Shader();
			shader.byteCode = new fishEyeShader();
			shader.data.center_x.value = [center_x];
			shader.data.center_y.value = [center_y];
			shader.data.radius.value = [radius];
			shaderfilter = new ShaderFilter(shader);
			return shaderfilter;
		}
		
		public static function getZoomBlurFilter(center_x:Number = 0, center_y:Number = 0, amount:Number = 0.25, focalSize:Number = 100, isInverted:Boolean = false, edgeHardness:Number = 0):ShaderFilter
		{
			shader = new Shader();
			shader.byteCode = new zoomBlurShader();
			shader.data.center.value = [center_x, center_y];
			shader.data.amount.value = [amount];
			shader.data.focalSize.value = [focalSize];
			shader.data.vignette.value = [0];
			shader.data.invert.value = [(int)(isInverted)];
			shader.data.edgeHardness.value = [edgeHardness];
			shaderfilter = new ShaderFilter(shader);
			return shaderfilter;
		}
		
		public static function getMotionBlur(amount:Number = 2, angle:Number = 0):ShaderFilter
		{
			shader = new Shader();
			shader.byteCode = new motionBlurShader();
			shader.data.amount.value = [amount];
			shader.data.angle.value = [angle];
			shaderfilter = new ShaderFilter(shader);
			return shaderfilter;
		}
	
	}

}