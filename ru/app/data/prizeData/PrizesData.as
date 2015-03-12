/**
 * Created by juka on 09.04.14.
 */
package ru.app.data.prizeData {

public class PrizesData {

	private var _items:Vector.<PrizeData>;

	public function PrizesData() {

	}

	public function setData(data:Object):void {
		_items = new Vector.<PrizeData>;

		for each (var item:Object in data) {
			var puzzleData:PrizeData = new PrizeData();
			puzzleData.setData(item);
			_items.push(puzzleData);
		}
	}

	public function get items():Vector.<PrizeData> {
		return _items;
	}

	public function set items(value:Vector.<PrizeData>):void {
		_items = value;
	}
}
}
