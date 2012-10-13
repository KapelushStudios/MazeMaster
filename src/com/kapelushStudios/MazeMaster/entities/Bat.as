package com.kapelushStudios.MazeMaster.entities 
{
	import com.kapelushStudios.MazeMaster.utils.Texture;
	/**
	 * ...
	 * @author matiki1231
	 */
	public class Bat extends EntityHostile
	{
		
		public function Bat() 
		{
			super(this, Texture.getEntity(EntityType.BAT), EntityType.BAT, "Bat");
		}
		
	}

}