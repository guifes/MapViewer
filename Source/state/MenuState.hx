package state;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import simple.SPEngine;
import simple.display.SPState;
import simple.display.tilemap.SPTileMap;

class MenuState extends SPState
{
	private static inline var TILE_SIZE = 32;
	private static inline var WIDTH = 64;
	private static inline var HEIGHT = 64;

    var tilemap: SPTileMap;

	public override function init()
	{
		var bitmapData: BitmapData = Assets.getBitmapData("assets/textures/atlas.png");
		
        tilemap = new SPTileMap();
        
        tilemap.loadMapFromArray([for(i in 0...WIDTH * HEIGHT) i], WIDTH, HEIGHT, bitmapData, TILE_SIZE, TILE_SIZE);
        
        add(tilemap);
	}

    var tilemap_pos: Point;
    var initial_pos: Point;

    public override function update(elapsed: Int, deltaTime: Int)
    {
        var pos = SPEngine.mouseManager.worldMouse.get_screen_position();

        if(SPEngine.mouseManager.worldMouse.left.just_pressed)
        {
			tilemap_pos = new Point(tilemap.x, tilemap.y);
			initial_pos = pos;
        }
        else if(SPEngine.mouseManager.worldMouse.left.pressed)
        {
			tilemap.x = (pos.x - initial_pos.x) + tilemap_pos.x;
            tilemap.y = (pos.y - initial_pos.y) + tilemap_pos.y;
        }
    }
}