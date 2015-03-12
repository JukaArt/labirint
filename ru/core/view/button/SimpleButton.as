/**
 * By: boluchevsky
 * Date: 28.06.12
 * Time: 10:38
 */
package ru.core.view.button {
import ru.core.Core;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class SimpleButton extends Sprite {
	private var _id:uint;
	private var _ui:MovieClip;
	private var _label:String;
	private var _clicked:Function;
	private var _back:Boolean;
	private var _viewLabel:String;

	public function SimpleButton(ui:MovieClip, label:String, id:uint, clicked:Function, back:Boolean, added:Boolean, viewLabel:String) {
		_ui = ui;
		_label = label;
		_id = id;
		_clicked = clicked;
		_back = back;
		_viewLabel = viewLabel;

		if (_ui.label)
			_ui.label.text = _label;

		if (added) {
			x = _ui.x;
			y = _ui.y;

			_ui.x = 0;
			_ui.y = 0;
		}


		addChild(_ui);

		mouseChildren = false;

		enable();
	}

	//public
	public function enable():void {
		buttonMode = true;

		Core.instance.eventManager.regEvent(this, MouseEvent.CLICK, clickHandler, _viewLabel);
	}

	public function disable():void {
		buttonMode = false;

		Core.instance.eventManager.clearByCallback(this, clickHandler);
	}


	// properties
	public function set label(value:String):void {
		_label = value;

		if (_ui.label)
			_ui.label.text = _label;
	}

	public function get label():String { return _label; }

	public function get viewLabel():String { return _viewLabel; }

	public function get id():uint { return _id; }

	public function set id(value:uint):void { _id = value; }

	public function get ui():MovieClip { return _ui; }


	// handlers
	protected function clickHandler(event:MouseEvent):void {

		if (_clicked != null) {
			if (_back) {
				_clicked(this);
			}
			else {
				_clicked();
			}
		}
	}

}
}
