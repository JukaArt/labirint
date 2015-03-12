/**
 * User: ilija
 * Date: 07.11.12
 * Time: 16:47
 */
package ru.core.manager {
import ru.core.Core;
import ru.core.view.container.RenderContainer;
import ru.core.view.render.BlittingObject;
import ru.core.view.render.BlittingPool;

import flash.display.BitmapData;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;

public class RenderManager {
	private var _pool:BlittingPool;
	private var _renderContainer:RenderContainer;
	private var _rect:Rectangle;
	private var _point:Point;
	private var _viewLabel:String = "RenderManager";

	public function RenderManager() {
		_pool = new BlittingPool();
		_rect = new Rectangle();
		_point = new Point();
	}


	// public
	public function renderOn():void {
		Core.instance.eventManager.regEvent(Core.instance.stage, Event.ENTER_FRAME, frameHandler, _viewLabel);
	}

	public function renderOff():void {
		Core.instance.eventManager.clearById(_viewLabel);
	}

	public function regNewObject(item:BlittingObject):void {
		item.renderItemId = _pool.setClip(item.renderItem);
		item.totalFrames = _pool.getClipByName(item.renderItemId).totalFrames;
		_pool.setRenderItem(item);
	}

	public function setContainer(container:RenderContainer):void {
		_renderContainer = container;
	}

	public function clearPool(label:String):void {
		_pool.releaseStack(label);
	}


	// private
	private function drawData(bitmapData:BitmapData, point:Point):void {
		_rect.width = bitmapData.width;
		_rect.height = bitmapData.height;
		_renderContainer.drawLayer.bitmapData.copyPixels(bitmapData, _rect, point, null, null, true);
	}


	// handlers
	private function frameHandler(event:Event):void {
		_rect.width = Core.instance.settings.appWidth;
		_rect.height = Core.instance.settings.appHeight;

		_renderContainer.drawLayer.bitmapData.fillRect(_rect, 0xFFFFFF);

		for each (var item:BlittingObject in _pool.renderStack) {
			_point.x = item.x;
			_point.y = item.y;
			drawData(_pool.getCacheByName(item.renderItemId)[item.currentFrame], _point);
			item.updateFrame();
		}

	}

}
}
