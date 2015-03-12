/**
 * By: boluchevsky
 * Date: 16.09.12
 * Time: 19:02
 */
package ru.app.pages {

import ru.core.Core;
import ru.core.manager.Settings;
import ru.core.view.button.AnimatedButton;
import ru.core.view.primary.Page;
import ru.core.view.render.BlittingObject;
import ru.core.view.util.Paging;

import lib.DummyBoyRunningUI;
import lib.SampleButtonUI;
import lib.SamplePageUI;

public class SamplePage extends Page {
	private var _ui:SamplePageUI;
	private var _closeButton:AnimatedButton;

	public function SamplePage() {

	}

	override protected function setup():void {
		_ui = new SamplePageUI();
		addChild(_ui);

		_closeButton = addButton(new SampleButtonUI(), "CLOSE", 0, closeHandler);
		addChild(_closeButton);

		var popupBtn:AnimatedButton = addButton(_ui.popupBtn, "", 1, showPopup, true, true);
		addChild(popupBtn);

		// PAGING
//		var paging:Paging = new Paging(20, Core.instance.settings.appWidth);
//		paging.y = Core.instance.settings.appHeight - 80;
//		addChild(paging);

		createAnimations();
	}

	private function createAnimations():void {
		var count:uint = Math.random() * 500;
		for (var i:int = 0; i < count; i++) {
//			var anim:DummyBoyRunningUI = new DummyBoyRunningUI();

//
			var anim:BlittingObject = new BlittingObject(DummyBoyRunningUI, super.viewLabel);
			anim.x = Math.random() * Core.instance.settings.appWidth;
			anim.y = Math.random() * Core.instance.settings.appHeight;
			addChild(anim);
		}

		Core.instance.render.renderOn();
	}

	private function showPopup(item:AnimatedButton):void {
		Core.instance.uiManager.showPopup(Settings.SAMPLE_POPUP);
	}

	private function closeHandler():void {
		Core.instance.uiManager.showPage(Settings.SAMPLE_PAGE);
	}

}
}
