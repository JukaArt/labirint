/**
 * By: boluchevsky
 * Date: 16.09.12
 * Time: 18:50
 */
package ru.core.view.primary {
import ru.core.Core;
import ru.core.manager.Settings;
import ru.core.view.button.AnimatedButton;

import flash.display.MovieClip;

public class Popup extends View {
    private var _graphics:MovieClip;

    public function Popup(ui:MovieClip) {
        _graphics = ui;
        addChild(_graphics);
    }

    override public function init():void {
        Core.instance.animationManager.showPopup(this);
		setCloseBtn();
    }

	override public function destroy():void {
		super.destroy();
	}

    protected function setCloseBtn():void {
        var btnClass:Class = Core.instance.factory.getClass(Settings.CLOSE_BUTTON);
        var btnUI:MovieClip = new btnClass as MovieClip;

        var btn:AnimatedButton = addButton(btnUI, "", 0, closePopup, true, false);

        btn.x = (_graphics.x + _graphics.width) - btn.width / 2;
        btn.y = _graphics.y + btn.height / 2;

        addChild(btn);
    }

    protected function closePopup(item:AnimatedButton = null):void {
		Core.instance.eventManager.clearById(super.viewLabel);
		Core.instance.animationManager.hidePopup(this);
    }

	protected function addButton(ui:MovieClip, label:String, id:uint = 0, clicked:Function = null, back:Boolean = false, added:Boolean = false, animationType:uint = 0):AnimatedButton {
		var btn:AnimatedButton = new AnimatedButton(ui, label, id, clicked, back, added, animationType, super.viewLabel);
		return btn;
	}
}
}
