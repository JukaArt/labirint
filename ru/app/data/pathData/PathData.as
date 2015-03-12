/**
 * Created by juka on 10.04.14.
 */
package ru.app.data.pathData {
public class PathData {


	private var _items:Vector.<StepData>;

	public function PathData() {


	}

	public function setData(data:Array):void {
		_items = new Vector.<StepData>;

		var num:Number = 0;
		for each (var item:Object in data) {
			_items.push(new StepData(data[num]));
			num++;
		}
	}

	public function get items():Vector.<StepData> {
		return _items;
	}

	public function set items(value:Vector.<StepData>):void {
		_items = value;
	}
}
}
