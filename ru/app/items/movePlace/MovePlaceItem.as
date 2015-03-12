/**
 * Created by juka on 27.02.14.
 */
package ru.app.items.movePlace {
import com.greensock.TweenMax;

import flash.display.Sprite;
import flash.events.MouseEvent;

import lib.MovePlaceUI;

import ru.core.Core;


public class MovePlaceItem extends Sprite {

	private var _ui:MovePlaceUI;

	public function MovePlaceItem() {
		_ui = new MovePlaceUI();
		addChild(_ui);

		Core.instance.eventManager.regEvent(_ui, MouseEvent.ROLL_OVER, uiRollOverHandler);
		Core.instance.eventManager.regEvent(_ui, MouseEvent.ROLL_OUT, uiRollOutHandler);
	}
	//public


	public function rotateUI(value:Number):void {
		_ui.rotation = value;
	}

	//handlers


	public function uiRollOverHandler(e:MouseEvent = null):void {
		TweenMax.to(_ui,.3, {alpha: 0.5});
	}


	public function uiRollOutHandler(e:MouseEvent = null):void {
		TweenMax.to(_ui,.3, {alpha: 1});
	}

}
}
