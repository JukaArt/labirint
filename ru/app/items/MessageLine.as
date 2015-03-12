/**
 * Created by juka on 07.04.14.
 */
package ru.app.items {
import flash.display.Sprite;

import lib.MsgLineUI;

public class MessageLine extends Sprite {

	private var _ui:MsgLineUI;


	public function MessageLine() {
		_ui = new MsgLineUI();
		addChild(_ui);

		_ui.x = 770;
		_ui.y = 64.5;

		_ui.label.text = "";

	}

	public function setTextMessage(text:String):void {
		_ui.label.text = text;
	}

}
}
