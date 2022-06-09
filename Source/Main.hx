package;

import haxe.Resource;
import haxe.ui.Toolkit;
import haxe.ui.core.Screen;
import openfl.Assets;
import openfl.Lib;
import openfl.display.Sprite;
import simple.SPEngine;
import state.MenuState;

class Main extends Sprite
{
	static inline var TARGET_WIDTH = 600;

	public function new()
	{
		super();

		// HaxeUI
		Toolkit.scale = SPEngine.getGameZoomForTargetWidth(TARGET_WIDTH);
		Toolkit.theme = 'dark';
		Toolkit.init();
				
		// Simple
		SPEngine.start(this, TARGET_WIDTH, () -> new MenuState());
	}
}