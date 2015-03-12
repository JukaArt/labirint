/**
 * Created by juka on 26.02.14.
 */
package ru.app.items.cards {
import flash.display.Sprite;

import lib.OpenCardUI;
import lib.PrizeUI;

public class CardItem extends Sprite {

	private var _ui:OpenCardUI;
	private var _id:uint;


	public function CardItem() {
		_ui = new OpenCardUI();
		addChild(_ui);
	}

	public function setPrize(obj:*):void {
		_ui.container.addChild(obj);
		_id = obj.id;

	}

	public function get id():uint {
		return _id;
	}

	public function set id(value:uint):void {
		_id = value;
	}
}
}
