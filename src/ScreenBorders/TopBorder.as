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
	public class TopBorder extends Entity
	{
		private var _tiles:Tilemap;
		private var _grid:Grid;
		
		public function TopBorder() 
		{
			_grid = new Grid(640, 485, 10, 10, 0, 0);
			mask = _grid;
			_grid.setRect(1, 0, 30, 1, true);
			
			type = "topBorder";
		}
		
	}

}