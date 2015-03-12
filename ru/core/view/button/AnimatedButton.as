/**
 * By: boluchevsky
 * Date: 28.06.12
 * Time: 10:41
 */
package ru.core.view.button {

import ru.core.Core;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class AnimatedButton extends SimpleButton {
    private var _ui:MovieClip;
    private var _animType:uint;

    public function AnimatedButton(ui:MovieClip, label:String, id:uint = 0, clicked:Function = null, back:Boolean = false, added:Boolean = false, animationType:uint = 0, viewLabel:String = "btn") {
        super(ui, label, id, clicked, back, added, viewLabel);
        _animType = animationType;
        _ui = ui;
    }


    // OVERRIDES
    override public function enable():void {
        super.enable();

		Core.instance.eventManager.regEvent(this, MouseEvent.MOUSE_OVER, overHandler, super.viewLabel);
		Core.instance.eventManager.regEvent(this, MouseEvent.MOUSE_OUT, outHandler, super.viewLabel);
    }

    override public function disable():void {
        super.disable();
        outHandler();

		Core.instance.eventManager.clearByCallback(this, overHandler);
		Core.instance.eventManager.clearByCallback(this, outHandler);
    }


    // PROTECTED
    protected function outHandler(event:MouseEvent = null):void {
        Core.instance.animationManager.buttonOut(_ui, _animType);
    }

    protected function overHandler(event:MouseEvent = null):void {
        Core.instance.animationManager.buttonOver(_ui, _animType);
    }

}
}
