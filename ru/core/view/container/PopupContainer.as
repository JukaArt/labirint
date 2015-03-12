/**
 * By: boluchevsky
 * Date: 16.09.12
 * Time: 15:11
 */
package ru.core.view.container {
import com.greensock.TweenMax;

import ru.core.Core;
import ru.core.view.primary.Container;
import ru.core.view.primary.Popup;
import ru.core.view.primary.View;

import flash.display.Sprite;

public class PopupContainer extends Container {
	private var _currentPopup:Popup;
	private var _pool:Vector.<Popup>;

	private var _black:Sprite;

	public function PopupContainer() {
		setup();
	}

	private function setup():void {
		_black = new Sprite();
		_black.graphics.beginFill(0x000, .4);
		_black.graphics.drawRect(0, 0, Core.instance.settings.appWidth, Core.instance.settings.appHeight);
		_black.graphics.endFill();

		_black.visible = false;
		_black.alpha = 0;

		addChild(_black);

		_pool = new Vector.<Popup>;
	}


	public function addPopup(popup:Popup):void {
		if (_pool.length > 0) {
			_pool.push(popup);
		}
		else {
			_pool.push(popup);
			showPopup(popup);
		}
	}

	public function removePopup():void {
		if (_currentPopup) {
			removeChild(_currentPopup);
			_currentPopup.destroy();
		}
	}

	override public function remove(item:View):void {
		super.remove(item);
//        TweenMax.to(_black, .5, {autoAlpha:0});


		// CLEAR POOL
		var id:int = _pool.indexOf(item as Popup);

		if (id >= 0)
			_pool.splice(id, 1);

		if (_pool.length > 0)
			showPopup(_pool[0]);
		else
			TweenMax.to(_black, .5, {autoAlpha:0});
	}

	public function get black():Sprite {
		return _black;
	}


	// private
	private function showPopup(popup:Popup):void {
		_currentPopup = popup;
		_currentPopup.container = this;
		addChild(_currentPopup);

		_currentPopup.init();

		TweenMax.to(_black, .5, {autoAlpha:1});
	}


}
}
