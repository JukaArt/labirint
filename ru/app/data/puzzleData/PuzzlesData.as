/**
 * Created by juka on 08.04.14.
 */
package ru.app.data.puzzleData {
public class PuzzlesData {


	private var _items:Vector.<PuzzleData>;

	public function PuzzlesData() {

	}


	public function setData(data:Object):void {
		_items = new Vector.<PuzzleData>;

		for each (var item:Object in data) {
			var puzzleData:PuzzleData = new PuzzleData();
			puzzleData.setData(item);
			_items.push(puzzleData);
		}
	}

	public function get items():Vector.<PuzzleData> {
		return _items;
	}

	public function set items(value:Vector.<PuzzleData>):void {
		_items = value;
	}
}
}
