/**
 * By: boluchevsky
 * Date: 16.09.12
 * Time: 18:15
 */
package ru.core.view.primary {
import ru.core.Core;
import ru.core.view.button.AnimatedButton;

import flash.display.MovieClip;

public class Page extends View {

	public function Page() {

	}

	override public function destroy():void {
		while (this.numChildren) {
			this.removeChildAt(0);
		}

		super.destroy();
	}

	override public function init():void {
		setup();
		Core.instance.animationManager.pageShow(this);
	}

	override public function hide():void {
		Core.instance.eventManager.clearById(super.viewLabel);
		Core.instance.render.clearPool(super.viewLabel);
		Core.instance.animationManager.pageHide(this);
	}

	protected function setup():void {

	}

	protected function addButton(ui:MovieClip, label:String, id:uint = 0, clicked:Function = null, back:Boolean = false, added:Boolean = false, animationType:uint = 0):AnimatedButton {
		var btn:AnimatedButton = new AnimatedButton(ui, label, id, clicked, back, added, animationType, super.viewLabel);
		return btn;
	}
}
}
