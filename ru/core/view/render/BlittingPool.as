/**
 * User: ilija
 * Date: 07.11.12
 * Time: 16:46
 */
package ru.core.view.render {
import avmplus.getQualifiedClassName;

import flash.display.BitmapData;
import flash.display.MovieClip;

public class BlittingPool {
	private var _lib:Object;
	private var _cache:Object;

	private var _renderStack:Vector.<BlittingObject>;

	public function BlittingPool() {
		_lib = new Object();
		_cache = new Object();
		_renderStack = new Vector.<BlittingObject>;
	}


	// properties
	public function get renderStack():Vector.<BlittingObject> {
		return _renderStack;
	}


	// public
	public function setClip(clip:Class):String {
		var name:String = getQualifiedClassName(clip);

		if (_lib[name]) {
			return name;
		}

		var data:MovieClip = new clip as MovieClip;

		_cache[name] = createClip(data);
		_lib[name] = data;

		return name;
	}

	public function getClipByName(name:String):MovieClip {
		return _lib[name];
	}

	public function getClipByClass():void {

	}

	public function getCacheByName(name:String):Vector.<BitmapData> {
		return _cache[name];
	}

	public function setRenderItem(blitt:BlittingObject):void {
		_renderStack.push(blitt);
	}

	public function releaseStack(label:String):void {
		var newStack:Vector.<BlittingObject> = new Vector.<BlittingObject>;

		for each (var item:BlittingObject in _renderStack) {
			if(item.id != label){
				trace(item.id, label);
				newStack.push(item);
			}
		}

		_renderStack = null;
		_renderStack = newStack;
	}

	// private
	private function createClip(animation:MovieClip):Vector.<BitmapData> {
		var cache:Vector.<BitmapData> = new Vector.<BitmapData>;

		for (var i:int = 1; i <= animation.totalFrames; i++) {
			animation.gotoAndStop(i);

			var data:BitmapData = new BitmapData(animation.width, animation.height, true, 0x00000000);
			data.draw(animation);

			cache.push(data);
		}

		return cache;
	}

}
}
