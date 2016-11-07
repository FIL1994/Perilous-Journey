package ScreenBorders 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	/**
	 * ...
	 * @author Philip VR
	 */
	public class BottomBorder extends Entity
	{
		private var _tiles:Tilemap;
		private var _grid:Grid;
		
		public function BottomBorder() 
		{
			_grid = new Grid(640, 485, 10, 10, 0, 0);
			mask = _grid;
			_grid.setRect(2, 23, 30, 1, true);
			
			type = "bottomBorder";
		}
		
	}

}