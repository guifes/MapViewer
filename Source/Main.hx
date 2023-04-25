package;

import haxe.ui.Toolkit;
import openfl.display.Sprite;
import simple.SPEngine;
import state.MenuState;

class Main extends Sprite
{
	static inline var TARGET_WIDTH = 1024;

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