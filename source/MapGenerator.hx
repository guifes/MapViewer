package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;
import flash.errors.Error;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class MapGenerator
{
	private static var worldSize:Int = 129;
	private static var rangeReductionFactor:Float = 0.7;

	public static function diamondSquare(rows:Int, cols:Int):Array<Array<Float>>
	{
		if(rows <= 129 && cols <= 129)
		{
			var world:Array<Array<Float>> = new Array<Array<Float>>();

			for(i in 0 ... worldSize)
			{
				world[i] = new Array<Float>();

				for(j in 0 ... worldSize)
				{
					world[i][j] = -999;
				}
			}

			world[0][0] = randomRange(1);
			world[0][worldSize - 1] = randomRange(1);
			world[worldSize - 1][0] = randomRange(1);
			world[worldSize - 1][worldSize - 1] = randomRange(1);
				
			iterateDiamondSquare(world, 0, 0, worldSize - 1, worldSize - 1, rangeReductionFactor);

			var indexes:Array<Array<Float>> = new Array<Array<Float>>();

			for(i in 0 ... rows)
			{
				indexes[i] = new Array<Float>();

				for(j in 0 ... cols)
				{
					indexes[i][j] = world[i][j];
				}
			}

			return indexes;
		}
		else
		{
			throw new Error("rows and cols must be < 129");
		}		
	}

	private static function iterateDiamondSquare(world:Array<Array<Float>>, x1:Int, y1:Int, x2:Int, y2:Int, range:Float):Void
	{
		var x:Int = x1 + Std.int(((x2 - x1) / 2));
		var y:Int = y1 + Std.int(((y2 - y1) / 2));

		var average:Float = 0;
		average += world[x1][y1];
		average += world[x1][y2];
		average += world[x2][y1];
		average += world[x2][y2];
		average *= 0.25;

		world[x][y] = average + randomRange(range);

		if(world[x][y1] < -900)
		{
			world[x][y1] = ((world[x1][y1] + world[x2][y1]) * 0.5) + randomRange(range);
		}
		
		if(world[x][y2] < -900)
		{
			world[x][y2] = ((world[x1][y2] + world[x2][y2]) * 0.5) + randomRange(range);
		}

		if(world[x1][y] < -900)
		{
			world[x1][y] = ((world[x1][y1] + world[x1][y2]) * 0.5) + randomRange(range);
		}

		if(world[x2][y] < -900)
		{
			world[x2][y] = ((world[x2][y1] + world[x2][y2]) * 0.5) + randomRange(range);
		}

		if(x - x1 > 1)
		{
			iterateDiamondSquare(world, x1, y1, x, y, range * rangeReductionFactor);
			iterateDiamondSquare(world, x, y1, x2, y, range * rangeReductionFactor);
			iterateDiamondSquare(world, x1, y, x, y2, range * rangeReductionFactor);
			iterateDiamondSquare(world, x, y, x2, y2, range * rangeReductionFactor);
		}
	}

	private static function randomRange(range:Float):Float
	{
		return Math.random() * range * 2 - range;
	}
}