/**
 * Created by juka on 05.03.14.
 */
package ru.app.items.members {
import flash.display.Sprite;

import ru.core.Core;

public class Members extends Sprite {

	private var _items:Vector.<MemberItem>;

	public function Members() {
		_items = new Vector.<MemberItem>;

		for (var i:int = 0; i < 4; i++) {
			var item:MemberItem = new MemberItem(i);
			addChild(item);

			_items.push(item);
		}
		setActive();
	}

	public function setActive():void {
		for (var i:int = 0; i < _items.length; i++) {
			if(i == Core.instance.dataManager.game.currentMember - 1) {
				_items[i].setActive(true);
			} else {
				_items[i].setActive(false);
			}
		}
	}

	public function get items():Vector.<MemberItem> {
		return _items;
	}

	public function set items(value:Vector.<MemberItem>):void {
		_items = value;
	}
}
}
