/**
 * Created by juka on 27.02.14.
 */
package ru.app.items.prize {
import flash.display.Sprite;

import lib.PrizeUI;

public class PrizeItem extends Sprite {

	private var _ui:PrizeUI;
	private var _id:uint;

	public function PrizeItem() {
		_ui = new PrizeUI();
		addChild(_ui);
	}

	// public

	public function setView(pos:uint, onPuzzle:Boolean = false):void {
		if(onPuzzle) {
			pos++;
		}
		_ui.gotoAndStop(pos);
		_id = pos;
	}

	public function get id():uint {
		return _id;
	}

	public function set id(value:uint):void {
		_id = value;
	}
}
}
