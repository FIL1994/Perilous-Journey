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
	public class LeftBorder extends Entity
	{
		private var _tiles:Tilemap;
		private var _grid:Grid;
		
		public function LeftBorder() 
		{
			_grid = new Grid(640, 485, 10, 10, 0, 0);
			mask = _grid;
			_grid.setRect(0, 1, 1, 30, true);
			
			type = "leftBorder";
		}
		
	}

}