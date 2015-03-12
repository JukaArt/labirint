/**
 * By: boluchevsky
 * Date: 16.09.12
 * Time: 16:28
 */
package ru.core.manager {
import com.greensock.TweenMax;
import com.greensock.easing.Back;
import com.greensock.easing.Expo;

import ru.core.Core;
import ru.core.manager.animations.DefaultButtonAnimation;
import ru.core.view.primary.Page;
import ru.core.view.primary.Popup;

import flash.display.MovieClip;

public class AnimationManager {
	private var _defBtn:DefaultButtonAnimation;


	public function AnimationManager() {
		_defBtn = new DefaultButtonAnimation();
	}


	// BUTTON
	public function buttonOver(item:MovieClip, type:uint):void {
		switch (type) {
			case 0:
				_defBtn.buttonOverStandard(item);
				break;
		}
	}

	public function buttonOut(item:MovieClip, type:uint):void {
		switch (type) {
			case 0:
				_defBtn.buttonOutStandard(item);
				break;
		}
	}


	// PAGE ANIMATION
	public function pageShow(page:Page):void {
//		page.x = Core.instance.settings.appWidth;
		TweenMax.to(page, .5, {x:0});
	}

	public function pageHide(page:Page):void {
		TweenMax.to(page, .5, {x:-1000, onComplete:destroyPage, onCompleteParams:[page]});
	}

	private function destroyPage(page:Page):void {
		page.destroy();
	}


	// POPUP ANIMATION
	public function showPopup(popup:Popup):void {
		popup.x = (Core.instance.settings.appWidth - popup.width) / 2;
		popup.y = (Core.instance.settings.appHeight - popup.height) / 2 - 50;
		popup.alpha = 0;
		TweenMax.to(popup, .5, {y:popup.y + 30, alpha:1, ease:Back.easeOut});
	}

	public function hidePopup(popup:Popup):void {
		TweenMax.to(popup, .8, {y:popup.y + 100, alpha:0, ease:Back.easeIn, onComplete:destroyPopup, onCompleteParams:[popup]});
	}

	private function destroyPopup(popup:Popup):void {
		popup.destroy();
	}


	// SCROLL
	private function animateScroll(maskContainer:MovieClip, container:MovieClip, value:Number, offsetY:uint = 0):void {
		var ny:Number = Math.min(0, -(container.height - maskContainer.height)) * value + offsetY;
		TweenMax.to(container, 1, {y:ny, ease:Expo.easeOut});
	}

}
}
