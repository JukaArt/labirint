/**
 * User: ilija
 * Date: 17.10.12
 * Time: 12:00
 */
package ru.app.popups {
import ru.core.Core;
import ru.core.manager.Settings;
import ru.core.view.button.AnimatedButton;
import ru.core.view.primary.Popup;

import lib.SamplePopupUI;

public class SamplePopup extends Popup {
	private var _ui:SamplePopupUI;

	public function SamplePopup() {
		_ui = new SamplePopupUI();
		super(_ui);
	}

	override protected function closePopup(item:AnimatedButton = null):void {
		super.closePopup();
		Core.instance.uiManager.showPage(Settings.SAMPLE_PAGE);
	}
}
}
