/**
 * User: ilija
 * Date: 01.11.12
 * Time: 12:25
 */
package ru.core.manager.animations {
import com.greensock.TweenMax;

import flash.display.MovieClip;

public class DefaultButtonAnimation {

	public function DefaultButtonAnimation() {

	}

	public function buttonOverStandard(item:MovieClip):void {
		if (item.over)
			TweenMax.to(item.over, .5, {alpha:1});
	}

	public function buttonOutStandard(item:MovieClip):void {
		if (item.over)
			TweenMax.to(item.over, .5, {alpha:0});
	}
}
}
