package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.tile.FlxTilemap;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		var map:FlxTilemap = new FlxTilemap();

		var heights:Array<Array<Float>> = MapGenerator.diamondSquare(100, 100);
		
		var indexes:Array<Array<Int>> = new Array<Array<Int>>();
		
		for(i in 0 ... 100)
		{
			indexes[i] = new Array<Int>();
			
			for(j in 0 ... 100)
			{
				if(heights[i][j] > 0.5)
				{
					indexes[i][j] = 2;
				}
				else
				{
					indexes[i][j] = 24;
				}
			}
		}
		
		map.loadMapFrom2DArray(indexes, "assets/images/world.png", 32, 32);
		
		add(map);

		// var bounds:FlxRect = map.getBounds();
		// FlxG.camera.setScrollBounds(bounds.x, bounds.y, bounds.width, bounds.height);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	
	private var touchPoint:FlxPoint;
	private var cameraScroll:FlxPoint;
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// Check Input

		if (FlxG.mouse.justPressed)
		{
			trace("Just pressed");

			cameraScroll = FlxG.camera.scroll;
			touchPoint = FlxG.mouse.getScreenPosition();
		}
			
		if(FlxG.mouse.pressed)
		{
			var newPoint:FlxPoint = FlxG.mouse.getScreenPosition();
			
			var offset:FlxPoint = newPoint.subtractPoint(cameraScroll);

			offset.x = -offset.x;
			offset.y = -offset.y;

			FlxG.camera.scroll = offset;
		}
	}
}