/**
 * Created by juka on 21.04.14.
 */
package ru.app.api {
import flash.events.Event;
import flash.events.EventDispatcher;

import ru.app.data.puzzleData.PuzzleData;
import ru.app.items.puzzles.Puzzle;
import ru.app.items.puzzles.PuzzleItem;

public class PathChecker extends EventDispatcher{

	private var _path:Array;
	private var _closed:Array;
	private var _puzzles:Vector.<Vector.<PuzzleData>>;
	private var _startX:uint;
	private var _startY:uint;

	public function PathChecker(puzzles:Vector.<Vector.<PuzzleData>>) {
		_puzzles = puzzles;
	}

	public function createPath(puzzleId:uint):void {
		_path = [];
		_closed = [];

		trace("STARTPUZZLE", puzzleId);

		for (var l:int = 0; l < 7; l++) {
			for (var m:int = 0; m < 7; m++) {
				if(_puzzles[l][m].puzzleId == puzzleId) {
					_startX = m;
					_startY = l;
				}
				_puzzles[l][m].list = [];
				_puzzles[l][m].open = false;
			}
		}
		_puzzles[_startY][_startX].list.push(_puzzles[_startY][_startX].puzzleId);
		_path.push(_puzzles[_startY][_startX]);
		_path[0].open = true;
		findPath();
	}

	private function findPath():void {
		var testPuzzle:PuzzleData;

		if(_path[0].posY -1 >= 0) {
			testPuzzle = _puzzles[_path[0].posY - 1][_path[0].posX];
			if((_path[0].vector[0] == 1 && testPuzzle.vector[2] == 1) && !testPuzzle.open) {
				checkDirect(testPuzzle);
			}
		}
		if (_path[0].posX -1 >= 0) {
			testPuzzle = _puzzles[_path[0].posY][_path[0].posX - 1];
			if((_path[0].vector[3] == 1 && testPuzzle.vector[1] == 1) && !testPuzzle.open) {
				checkDirect(testPuzzle);
			}
		}
		if (_path[0].posY +1 < 7) {
			testPuzzle = _puzzles[_path[0].posY + 1][_path[0].posX];
			if((_path[0].vector[2] == 1 && testPuzzle.vector[0] == 1) && !testPuzzle.open) {
				checkDirect(testPuzzle);
			}
		}
		if (_path[0].posX +1 < 7) {
			testPuzzle = _puzzles[_path[0].posY][_path[0].posX + 1];
			if((_path[0].vector[1] == 1 && testPuzzle.vector[3] == 1) && !testPuzzle.open) {
				checkDirect(testPuzzle);
			}
		}

//		for (var i:int = 0; i < _path.length; i++) {
//			trace((_path[i] as PuzzleData).puzzleId);
//
//		}

		_path.splice(0, 1);

		if(_path.length != 0) {
			findPath();
		}
	}

	private function checkDirect(testObj:PuzzleData):void {
		_path.push(testObj);
		testObj.open = true;
		_closed.push(testObj);
		for (var i:int = 0; i < _path[0].list.length; i++) {
			testObj.list.push(_path[0].list[i]);
		}
		testObj.list.push(testObj.puzzleId);
	}

	public function getPath(puzzleId:uint):Array {
		trace("ENDPUZZLE", puzzleId);
		var tempArray:Array = [];
		for (var i:int = 0; i < _closed.length; i++) {
			if(_closed[i].puzzleId == puzzleId) {
				tempArray = _closed[i].list;
			}
		}

		if(tempArray.length > 0 ) {
			return tempArray;
		} else {
			return null;
		}

	}

}
}
