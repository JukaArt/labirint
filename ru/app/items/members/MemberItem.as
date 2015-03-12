/**
 * Created by juka on 05.03.14.
 */
package ru.app.items.members {
import flash.display.Sprite;

import lib.UserUI;

public class MemberItem extends Sprite{

	private var _ui:UserUI;
	private var _id:uint;

	public function MemberItem(id:uint) {
		_id = id;

		_ui = new UserUI();
		addChild(_ui);

		_ui.gotoAndStop(_id + 1);
		setActive(false);
		setUser(false);
	}


	public function setActive(value:Boolean):void {
		_ui.active.visible = value;
	}

	public function setUser(value:Boolean):void {
		_ui.user.visible = value;
	}
}
}
