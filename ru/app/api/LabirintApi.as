/**
 * Created by juka on 07.04.14.
 */
package ru.app.api {


public class LabirintApi {

	private var _prizes:PrizeDeal;
	private var _puzzlesCreator:PuzzlesCreator;
	private var _puzzles:Puzzles;
	private var _pathChecker:PathChecker;


	public function LabirintApi() {
		_prizes = new PrizeDeal();
		_puzzlesCreator = new PuzzlesCreator();
		_puzzles = new Puzzles(_puzzlesCreator.puzzleData);
	}

	public function createPrizeForMemebers():void {

	}

	public function initRequest(complete:Function):void {
		var initApi:InitApi = new InitApi(_puzzles);
		initApi.createJSON();
		complete(initApi.data);
	}

	public function endMemeberMotionRequest(gameId:uint, currentMember:uint, complete:Function):void {
		if(currentMember != 4) {
			currentMember++;
		} else {
			currentMember = 1;
		}
		complete(currentMember);
	}

	public function prizeTypeRequest(gameId:uint, playerId:uint, current:Number, complete:Function):void {
		complete(_prizes.prizes[playerId - 1][current]);
	}

	public function rotatePuzzleRequest(gameId:uint, playerId:uint, puzzleId:uint, rotateValue:Number, rotateVector:Array, complete:Function):void {
		complete();
	}

	public function motionPuzzleRequest(gameId:uint, playerId:uint, direction:Number, complete:Function):void {
		_puzzles.replacePuzzle(direction, complete);
	}

	public function motionMemberRequest(gameId:uint, playerId:uint, path:Object, complete:Function):void {
		complete(path);
	}


	public function cheсkPathRequest(gameId:uint, playerId:uint, startPuzzleId:uint, endPuzzleId:uint, complete:Function):void {
		_pathChecker = new PathChecker(_puzzles.puzzle);
		_pathChecker.createPath(startPuzzleId);
		var tempArray:Array = _pathChecker.getPath(endPuzzleId);
		trace("TEMPARRAY", tempArray);
		complete(tempArray);
	}
}
}