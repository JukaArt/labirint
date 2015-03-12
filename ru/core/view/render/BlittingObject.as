/**
 * User: ilija
 * Date: 07.11.12
 * Time: 15:29
 *
 *    Реализует кэширование таймлайн анимаций и последующее воспроизведение.
 *
 *    http://www.adobe.com/devnet/flash/articles/blitting_mc.html
 *
 */

package ru.core.view.render {
import ru.core.Core;

import flash.display.Sprite;

public class BlittingObject extends Sprite {
	private var _id:String;

	private var _currentFrame:uint = 0;
	private var _totalFrames:int;

	private var _renderItem:Class;
	private var _renderItemId:String;

	private var _play:Boolean = true;

	public function BlittingObject(item:Class, pageID:String) {
		_renderItem = item;
		_id = pageID;
		// register object
		Core.instance.render.regNewObject(this);
		init();
	}


	// public
	public function updateFrame():void {
		frameHandler();
	}

	public function init():void {

	}

	public function stop():void {

	}

	public function playFrom(frame:uint):void {

	}


	// private
	private function frameHandler():void {
		++_currentFrame;

		if (_currentFrame > _totalFrames)
			_currentFrame = 0;

//		Core.instance.render.drawData(_cache[_currentFrame], new Point(this.x, this.y));
	}


	// properties
	public function get renderItem():Class {
		return _renderItem;
	}

	public function get renderItemId():String {
		return _renderItemId;
	}

	public function set renderItemId(value:String):void {
		_renderItemId = value;
	}

	public function get totalFrames():int {
		return _totalFrames;
	}

	public function set totalFrames(value:int):void {
		_totalFrames = value - 1;
		_currentFrame = Math.random() * _totalFrames;
	}

	public function get currentFrame():uint {
		return _currentFrame;
	}

	public function set currentFrame(value:uint):void {
		_currentFrame = value;
	}

	public function get id():String {
		return _id;
	}
}
}
