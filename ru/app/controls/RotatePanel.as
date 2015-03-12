/**
 * Created by juka on 08.04.14.
 */
package ru.app.controls {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import lib.RotatePanelUI;

import ru.core.Core;

public class RotatePanel extends Sprite {

	private var _rotatePanel:RotatePanelUI;

	public function RotatePanel() {
		_rotatePanel = new RotatePanelUI();
		addChild(_rotatePanel);
		_rotatePanel.x = 900 - 25;
		_rotatePanel.y = 150 - 25;

		_rotatePanel.leftRotate.buttonMode = true;
		_rotatePanel.rightRotate.buttonMode = true;
		Core.instance.eventManager.regEvent(_rotatePanel.leftRotate, MouseEvent.CLICK, leftRotateClickHandler);
		Core.instance.eventManager.regEvent(_rotatePanel.rightRotate, MouseEvent.CLICK, rightRotateClickHandler);
	}


	private function leftRotateClickHandler(e:MouseEvent):void {
		dispatchEvent(new Event("leftRotate"));
	}

	private function rightRotateClickHandler(e:MouseEvent):void {
		dispatchEvent(new Event("rightRotate"));
	}
}
}
