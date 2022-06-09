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
		
		var map: FlxTilemap = new FlxTilemap();

		var heights:Array<Array<Float>> = MapGenerator.diamondSquare(100, 100);
		
		var indexes:Array<Array<Int>> = new Array<Array<Int>>();
		
		for(i in 0 ... 100)
		{
			indexes[i] = new Array<Int>();
			
			for(j in 0 ... 100)
			{
				if(heights[i][j] > 0.5)
				{
					indexes[i][j] = 400;
				}
				else if(heights[i][j] < 0)
				{
					indexes[i][j] = 731;
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
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// Check Input
			
		if(FlxG.mouse.pressed)
		{
			var newPoint:FlxPoint = FlxG.mouse.getScreenPosition();
			
			if(newPoint.x > (FlxG.width * 0.8))
			{
				FlxG.camera.scroll.x += 2;
			}
			else if(newPoint.x < FlxG.width * 0.2)
			{
				FlxG.camera.scroll.x -= 2;
			}
				
			if(newPoint.y > (FlxG.height * 0.8))
			{
				FlxG.camera.scroll.y += 2;
			}
			else if(newPoint.y < FlxG.height * 0.2)
			{
				FlxG.camera.scroll.y -= 2;
			}
		}
	}
}