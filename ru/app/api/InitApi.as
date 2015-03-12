/**
 * Created by juka on 07.04.14.
 */
package ru.app.api {
import ru.app.data.prizeData.PrizeData;
import ru.app.data.puzzleData.PuzzleData;
import ru.app.items.puzzles.Vector4;

public class InitApi {

	private static const PRIZE_AMOUNT:uint = 24;
	private static const PUZZLE_AMOUNT:uint = 50;

	private var _data:Object;

	private var _prizes:Array;
	private var _prizeType:Array;
	private var _rotations:Array;
	private var _puzzles:Puzzles;
	private var _prizesData:Vector.<PrizeData>;
	private var _puzzleData:Vector.<PuzzleData>;

	public function InitApi(puzzles:Puzzles) {
		_rotations = [0, 90, 180, 270];
		_prizes = [];
		_puzzles = puzzles;

		createPrizeData();
	}

	private function createPrizeData():void {
		_prizesData = new Vector.<PrizeData>;
		_prizeType = [];

		var tempArray:Array = [];

		for (var k:int = 0; k < PRIZE_AMOUNT; k++) {
			tempArray.push(k + 1);
		}

		_prizeType = randomizePrize(tempArray);

		for (var i:int = 0; i < PUZZLE_AMOUNT; i++) {
			var item:PrizeData = new PrizeData();
			_prizesData.push(item);
		}
		setPrizes();
	}

	private function setPrizes(showPrize:uint = 0):void {
		for (var i:int = 0; i < PUZZLE_AMOUNT; i++) {
			if(PRIZE_AMOUNT != showPrize && _prizesData[i].havePrize == false && i != 0 && i != 3 && i != 12 && i != 15) {
				var num:uint = Math.random() * 2;
				if(num == 0) {
					_prizesData[i].prizeId = showPrize;
					_prizesData[i].havePrize = true;
					showPrize++;
				}
			}
		}

		if(showPrize != PRIZE_AMOUNT) {
			setPrizes(showPrize);
		} else {
			showPrizeData();
		}
	}

	private function showPrizeData():void {
		for (var i:int = 0; i < _prizesData.length; i++) {
			var data:Object = new Object();
			data.havePrize = _prizesData[i].havePrize;
			if(_prizesData[i].havePrize) {
				data.prizeId = _prizesData[i].prizeId;
			}
			_prizes.push(data);
		}
	}

	private function createPuzzleData():void {
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
			item.setRotate(_rotations[uint(Math.random() * 4)]);
			items.push(item);
		}

		_puzzleData = new Vector.<PuzzleData>;
		_puzzleData = randomize(items);

		for (var l:int = 0; l < _puzzleData.length; l++) {
			var data:Object = new Object();
			data.viewType = _puzzleData[l].viewType;
			data.rotationVector = _puzzleData[l].rotationVector.vector;
			data.puzzleId = l;
			data.rotateValue = _puzzleData[l].rotateValue;
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

	private function randomizePrize(array:Array):Array {
		var tempArray:Array = [];
		var length:Number = array.length;
		for (var i:int = 0; i < length; i++) {
			var num:uint = Math.random() * (array.length - 1);
			tempArray.push(array[num]);
			array.splice(num, 1);
		}
		return tempArray;
	}


	public function createJSON():void {
		_data = new Object();
		_data.id = uint(Math.random() * 4) + 1;
		_data.firstPrizeId = 1;
		_data.puzzles = _puzzles.allPuzzles;
		_data.prizes = _prizes;
		_data.gameId = 1;
	}

	public function get data():Object {
		return _data;
	}

	public function set data(value:Object):void {
		_data = value;
	}
}
}
