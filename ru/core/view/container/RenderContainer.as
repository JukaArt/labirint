/**
 * User: ilija
 * Date: 09.11.12
 * Time: 10:51
 */
package ru.core.view.container {
import ru.core.Core;
import ru.core.view.primary.*;

import flash.display.Bitmap;
import flash.display.BitmapData;

public class RenderContainer extends Container {
	private var _drawLayer:Bitmap;

	public function RenderContainer() {
		_drawLayer = new Bitmap(new BitmapData(Core.instance.settings.appWidth, Core.instance.settings.appHeight));
		addChild(_drawLayer);
	}

	public function get drawLayer():Bitmap {
		return _drawLayer;
	}
}
}
