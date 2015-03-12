/**
 * User: ilija
 * Date: 02.11.12
 * Time: 15:44
 */
package ru.core.view.container {
import com.greensock.TweenMax;

import ru.core.Core;
import ru.core.view.primary.Container;

import flash.display.Sprite;

public class PreloaderContainer extends Container {
	private var _black:Sprite;

	public function PreloaderContainer() {
		setup();
	}

	// public
	public function show():void {
		TweenMax.to(_black, .5, {autoAlpha:1});
	}

	public function hide():void {
		TweenMax.to(_black, .5, {autoAlpha:0});
	}


	// private
	private function setup():void {
		_black = new Sprite();
		_black.graphics.beginFill(0x000, .4);
		_black.graphics.drawRect(0, 0, Core.instance.settings.appWidth, Core.instance.settings.appHeight);
		_black.graphics.endFill();

		_black.visible = false;
		_black.alpha = 0;

		addChild(_black);
	}
}
}
