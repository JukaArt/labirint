/**
 * User: ilija
 * Date: 21.11.12
 * Time: 14:13
 */
package ru.core.manager {
public class EventManager {
	private var _pool:Vector.<Object>;
	private var _status:Boolean;

	public function EventManager() {
		_pool = new Vector.<Object>;
	}


	// public
	public function regEvent(target:*, type:String, callBack:Function, id:String = "none"):void {
		_status = false;

		var data:Object = new Object();
		data.target = target;
		data.type = type;
		data.callBack = callBack;
		data.id = id;

		for each (var item:Object in _pool) {
			if (item.target == target) {
				if (item.type == type) {
					if (item.callBack == callBack) {
						return;
					}
				}
			}
		}

		addListener(data);
		_pool.push(data);

	}


	// WARNING: может удалить слушатели с нового объекта если его id такой же
	public function clearById(id:String):void {
		for each (var item:Object in _pool) {
			if(item.id == id) {
				removeListener(item);
			}
		}
	}

	public function clearByTarget(target:*):void {
		for each (var item:Object in _pool) {
			if(item.target == target) {
				removeListener(item);
			}
		}
	}

	public function clearByCallback(target:*, callBack:Function):void {
		for each (var item:Object in _pool) {
			if(item.target == target && item.callBack == callBack) {
				removeListener(item);
			}
		}
	}


	// private
	private function addListener(item:Object):void {
		item.target.addEventListener(item.type, item.callBack, false, 0, true);
	}

	private function removeListener(item:Object):void {
		var id:int = _pool.indexOf(item);

		if(id >= 0)
			_pool.splice(id, 1);

		item.target.removeEventListener(item.type, item.callBack);
	}


}
}
