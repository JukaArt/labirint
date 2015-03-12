/**
 * Created by juka on 27.02.14.
 */
package ru.app.data {
import ru.app.api.LabirintApi;
import ru.app.data.pathData.PathData;
import ru.app.data.prizeData.PrizesData;
import ru.app.data.puzzleData.PuzzlesData;
import ru.app.items.MessageLine;
import ru.app.items.puzzles.PuzzleItem;
import ru.core.data.*;


public class GameData extends Data {

	private var _currentMember:uint = 1;
	private var _userPrizesAmount:uint = 5;
	private var _movePlaceAmount:uint = 12;
	private var _prizesTotalAmount:uint = 24;
	private var _primePuzzlesAmount:uint = 16;
	private var _changeablePuzzlesAmount:uint = 34;

	private var _gameId:uint;
	private var _playerId:uint;
	private var _direction:uint;
	private var _currentTaskPrize:uint;

	private var _path:Array;
	private var _botPath:Array;
	private var _cardsId:Array;
	private var _playerPrizes:Array;
	private var _openPrize:Number;
	private var _myMotion:Boolean;
	private var _wayChosen:Boolean;

	private var _pathPuzzles:PathData;
	private var _puzzlePrizes:PrizesData;
	private var _allPuzzles:PuzzlesData;

	private var _currentElement:PuzzleItem;

	private var _apiLabirint:LabirintApi;

	private var _msgLine:MessageLine;


	public static const TYPE:String = "GameData";

	public function GameData() {
		super.type = TYPE;
	}

	public function get prizesTotalAmount():uint {
		return _prizesTotalAmount;
	}

	public function set prizesTotalAmount(value:uint):void {
		_prizesTotalAmount = value;
	}

	public function get userPrizesAmount():uint {
		return _userPrizesAmount;
	}

	public function set userPrizesAmount(value:uint):void {
		_userPrizesAmount = value;
	}

	public function get primePuzzlesAmount():uint {
		return _primePuzzlesAmount;
	}

	public function set primePuzzlesAmount(value:uint):void {
		_primePuzzlesAmount = value;
	}

	public function get changeablePuzzlesAmount():uint {
		return _changeablePuzzlesAmount;
	}

	public function set changeablePuzzlesAmount(value:uint):void {
		_changeablePuzzlesAmount = value;
	}

	public function get movePlaceAmount():uint {
		return _movePlaceAmount;
	}

	public function set movePlaceAmount(value:uint):void {
		_movePlaceAmount = value;
	}

	public function get currentElement():PuzzleItem {
		if(!_currentElement)
			_currentElement = new PuzzleItem();
		return _currentElement;
	}

	public function set currentElement(value:PuzzleItem):void {
		_currentElement = value;
	}

	public function get wayChosen():Boolean {
		return _wayChosen;
	}

	public function set wayChosen(value:Boolean):void {
		_wayChosen = value;
	}

	public function get direction():uint {
		return _direction;
	}

	public function set direction(value:uint):void {
		_direction = value;
	}

	public function get path():Array {
		if(!_path)
			_path = [];

		return _path;
	}

	public function set path(value:Array):void {
		_path = value;
	}

	public function get currentMember():uint {
		return _currentMember;
	}

	public function set currentMember(value:uint):void {
		_currentMember = value;
	}

	public function get currentTaskPrize():uint {
		return _currentTaskPrize;
	}

	public function set currentTaskPrize(value:uint):void {
		_currentTaskPrize = value;
	}

	public function get apiLabirint():LabirintApi {
		if(!_apiLabirint) {
			_apiLabirint = new LabirintApi();
		}
		return _apiLabirint;
	}

	public function set apiLabirint(value:LabirintApi):void {
		_apiLabirint = value;
	}

	public function get allPuzzles():PuzzlesData {
		if(!_allPuzzles) {
			_allPuzzles = new PuzzlesData();
		}
		return _allPuzzles;
	}

	public function set allPuzzles(value:PuzzlesData):void {
		_allPuzzles = value;
	}

	public function get puzzlePrizes():PrizesData {
		if(!_puzzlePrizes) {
			_puzzlePrizes = new PrizesData();
		}
		return _puzzlePrizes;
	}

	public function set puzzlePrizes(value:PrizesData):void {
		_puzzlePrizes = value;
	}

	public function get playerId():uint {
		return _playerId;
	}

	public function set playerId(value:uint):void {
		_playerId = value;
	}

	public function get cardsId():Array {
		if(!_cardsId) {
			_cardsId = [];
		}
		return _cardsId;
	}

	public function set cardsId(value:Array):void {
		_cardsId = value;
	}

	public function get gameId():uint {
		return _gameId;
	}

	public function set gameId(value:uint):void {
		_gameId = value;
	}

	public function get pathPuzzles():PathData {
		if(!_pathPuzzles) {
			_pathPuzzles = new PathData();
		}
		return _pathPuzzles;
	}

	public function set pathPuzzles(value:PathData):void {
		_pathPuzzles = value;
	}

	public function get myMotion():Boolean {
		return _myMotion;
	}

	public function set myMotion(value:Boolean):void {
		_myMotion = value;
	}

	public function get botPath():Array {
		if(!_botPath) {
			_botPath = [];
		}
		return _botPath;
	}

	public function set botPath(value:Array):void {
		_botPath = value;
	}

	public function get openPrize():Number {
		return _openPrize;
	}

	public function set openPrize(value:Number):void {
		_openPrize = value;
	}

	public function get playerPrizes():Array {
		if(!_playerPrizes) {
			_playerPrizes = [];
		}
		return _playerPrizes;
	}

	public function set playerPrizes(value:Array):void {
		_playerPrizes = value;
	}

	public function get msgLine():MessageLine {
		if(!_msgLine) {
			_msgLine = new MessageLine();
		}
		return _msgLine;
	}

	public function set msgLine(value:MessageLine):void {
		_msgLine = value;
	}
}
}
