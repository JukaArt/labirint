/**
 * Created by juka on 17.04.14.
 */
package ru.app.api {
import ru.app.data.puzzleData.PuzzleData;
import ru.app.items.puzzles.Vector4;

public class PuzzlesCreator {

	private static const PUZZLE_AMOUNT:Number = 50;

	private var _puzzleData:Vector.<PuzzleData>;
	private var _rotations:Array;
	private var _puzzles:Array;

	public function PuzzlesCreator() {
		_puzzles = [];
		_rotations = [0, 90, 180, 270];

		var items:Vector.<PuzzleData> = new Vector.<PuzzleData>;
		for (var i:int = 0; i < 34; i++) {
			var item:PuzzleData = new PuzzleData();
			var vector4:Vector4;
			if (i < 12) {
				item.viewType = 1;
				vector4 = new Vector4(1, 0, 1, 0);
			} else if (i < 27) {
				item.viewType = 3;
				vector4 = new Vector4(0, 1, 1, 0);
			} else {
				item.viewType = 2;
				vector4 = new Vector4(1, 1, 1, 0);

			}
			item.setVector4(vector4);
			var n:uint = uint(Math.random() * 4);
			item.setRotate(_rotations[n]);
			items.push(item);
		}

		_puzzleData = new Vector.<PuzzleData>;

		var tempArray:Vector.<PuzzleData> = new Vector.<PuzzleData>;
		tempArray = randomize(items);

		for (var l:int = 0; l < PUZZLE_AMOUNT; l++) {
			if(l == 0 || l == 6 || l == 42 || l == 48) {
				var puzzle:PuzzleData = new PuzzleData();
				puzzle.viewType = 3;
				vector4 = new Vector4(0, 1, 1, 0);
				puzzle.setVector4(vector4);
				_puzzleData.push(puzzle);
			} else if (l == 2 || l == 4 || l == 14 || l == 16 || l == 18 || l == 20 || l == 28 || l == 30 || l == 32 || l == 34 || l == 44 || l == 46) {
				var puzzleItem:PuzzleData = new PuzzleData();
				puzzleItem.viewType = 2;
				vector4 = new Vector4(1, 1, 1, 0);
				puzzleItem.setVector4(vector4);
				_puzzleData.push(puzzleItem);
			} else {
				_puzzleData.push(tempArray[0]);
				tempArray.splice(0, 1);
			}
		}

		for (var m:int = 0; m < _puzzleData.length; m++) {
			_puzzleData[m].puzzleId = m;
			if(m == 0 || m == 14 || m == 16 || m == 28) {
				_puzzleData[m].setRotate(0);
			} else if(m == 2 || m == 4 || m == 6 || m == 18) {
				_puzzleData[m].setRotate(90);
			} else if (m == 20 || m == 32 || m == 34 || m == 48) {
				_puzzleData[m].setRotate(180);
			} else if(m == 30 || m == 44 || m == 46 || m == 42){
				_puzzleData[m].setRotate(270);
			}
		}

		for (var t:int = 0; t < _puzzleData.length; t++) {
			var data:Object = new Object();
			data.viewType = _puzzleData[t].viewType;
			data.rotationVector = _puzzleData[t].rotationVector.vector;
			data.puzzleId = t;
			data.rotateValue = _puzzleData[t].rotateValue;
			_puzzles.push(data);
		}
	}

	private function randomize(array:Vector.<PuzzleData>):* {
		var items:Vector.<PuzzleData> = new Vector.<PuzzleData>;
		var length:Number = array.length;
		for (var i:int = 0; i < length; i++) {
			var num:uint = Math.random() * (array.length - 1);
			items.push(array[num]);
			array.splice(num, 1);
		}

		return items;
	}

	public function get puzzleData():Vector.<PuzzleData> {
		return _puzzleData;
	}

	public function set puzzleData(value:Vector.<PuzzleData>):void {
		_puzzleData = value;
	}

	public function get puzzles():Array {
		return _puzzles;
	}

	public function set puzzles(value:Array):void {
		_puzzles = value;
	}
}
}
