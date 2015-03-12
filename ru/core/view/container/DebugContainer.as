/**
 * User: ilija
 * Date: 21.11.12
 * Time: 13:05
 */
package ru.core.view.container {
import ru.core.Core;
import ru.core.view.primary.Container;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.system.System;

import lib.DebugUI;

public class DebugContainer extends Container {
	private var _ui:DebugUI;
	private var _viewLabel:String = "DebugContainer";


	public function DebugContainer() {
		setup();
	}

	private function setup():void {
		_ui = new DebugUI();
		_ui.y = 200;
		addChild(_ui);
	}


	// public
	public function enable():void {
		Core.instance.eventManager.regEvent(_ui,  MouseEvent.MOUSE_DOWN, drugAndDropHandler, _viewLabel);
		Core.instance.eventManager.regEvent(_ui,  MouseEvent.MOUSE_UP, stopDrugHandler, _viewLabel);

		Core.instance.eventManager.regEvent(Core.instance.stage, Event.ENTER_FRAME, debugFrameHandler, _viewLabel);
	}

	public function disable():void {
		Core.instance.eventManager.clearById(_viewLabel);
	}


	// handlers
	private function debugFrameHandler(event:Event):void {
//		trace(System.totalMemoryNumber / 1024 / 1024);
		_ui.memoryLabel.text = "memory (Mb): " + (System.totalMemoryNumber / 1024 / 1024).toString();
	}

	private function drugAndDropHandler(event:MouseEvent):void {
		_ui.startDrag();
	}

	private function stopDrugHandler(event:MouseEvent):void {
		_ui.stopDrag();
	}
}
}
