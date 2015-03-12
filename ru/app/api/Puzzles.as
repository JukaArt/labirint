/**
 * Created by juka on 17.04.14.
 */
package ru.app.api {
import ru.app.data.puzzleData.PuzzleData;

public class Puzzles {


	private var _puzzle:Vector.<Vector.<PuzzleData>>;
	private var _allPuzzles:Vector.<PuzzleData>;
	private var _currentPuzzle:*;
	private var _complete:Function;
	private var _puzzleCreater:PuzzlesCreator;
	private var _directions:Array = [1, 3, 5, 1, 3, 5, 1, 3, 5, 1, 3, 5];
	private var _direction:uint;

	public function Puzzles(allPuzzles:Vector.<PuzzleData>) {
		_puzzle = new Vector.<Vector.<PuzzleData>>();
		_puzzleCreater = new PuzzlesCreator();
		_allPuzzles = allPuzzles;


		for (var i:int = 0; i < 7; i++) {
			var array:Vector.<PuzzleData> = new Vector.<PuzzleData>;
			for (var j:int = i * 7; j < (i + 1) * 7; j++) {
				array.push(_allPuzzles[j]);
			}
			_puzzle.push(array);
		}


		for (var l:int = 0; l < 7; l++) {
			for (var m:int = 0; m < 7; m++) {
				_puzzle[l][m].setParams(m, l);
			}
		}

		_currentPuzzle = _allPuzzles[_allPuzzles.length - 1];
	}

	public function replacePuzzle(direction:Number, complete:Function):void {
		_complete = complete;
		_direction = direction;
		if(direction >= 0 && direction < 3) {
			changePuzzles(_directions[direction], true, true);
		} else if(direction >= 3 && direction < 6) {
			changePuzzles(_directions[direction], true, false);
		} else if(direction >= 6 && direction < 9) {
			changePuzzles(_directions[direction], false, false);
		} else {
			changePuzzles(_directions[direction], false, true);
		}
	}

	private function changePuzzles(direction:uint, top:Boolean, vertical:Boolean):void {
		var dump:*;

		if(vertical) {

			if(top) {
				dump = _puzzle[6][direction];
				for (var i:int = 0; i < 6; i++) {
					_puzzle[6 - i][direction] = _puzzle[6 - (i + 1)][direction];
				}
				_puzzle[0][direction] = _currentPuzzle;
			} else {
				dump = _puzzle[0][direction];
				for (var l:int = 0; l < 6; l++) {
					_puzzle[l][direction] = _puzzle[l + 1][direction];
				}
				_puzzle[6][direction] = _currentPuzzle;
			}

		} else {
			if(top) {
				dump = _puzzle[direction][6];
				for (var k:int = 0; k < 6; k++) {
					_puzzle[direction][6 - k] = _puzzle[direction][6 - (k + 1)];
				}
				_puzzle[direction][0] = _currentPuzzle;
			} else {
				dump = _puzzle[direction][0];
				for (var r:int = 0; r < 6; r++) {
					_puzzle[direction][r] = _puzzle[direction][r + 1];
				}
				_puzzle[direction][6] = _currentPuzzle;
			}
		}
		_currentPuzzle = dump;

		_complete(_direction);
	}


	public function get puzzle():Vector.<Vector.<PuzzleData>> {
		return _puzzle;
	}

	public function set puzzle(value:Vector.<Vector.<PuzzleData>>):void {
		_puzzle = value;
	}

	public function get allPuzzles():Vector.<PuzzleData> {
		return _allPuzzles;
	}

	public function set allPuzzles(value:Vector.<PuzzleData>):void {
		_allPuzzles = value;
	}
}
}
