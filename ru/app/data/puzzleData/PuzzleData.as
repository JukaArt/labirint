/**
 * Created by juka on 07.04.14.
 */
package ru.app.data.puzzleData {
import ru.app.items.puzzles.Vector4;

public class PuzzleData {

	private var _posX:int;
	private var _posY:int;
	private var _prizeId:uint;
	private var _viewType:uint;
	private var _puzzleId:uint;
	private var _rotateValue:Number;

	private var _havePrize:Boolean;
	private var _open:Boolean;
	private var _activeStatus:Boolean;

	private var _list:Array;
	private var _vector:Array;
	private var _rotationPos:Array;
	private var _rotationVector:Vector4;

	public function PuzzleData() {

	}

	public function setData(data:Object):void {
		_viewType = data.viewType;
		_rotateValue = data.rotateValue;
		_puzzleId = data.puzzleId;
		_rotationPos = data.vector;
		_rotationVector = new Vector4(_rotationPos[0], _rotationPos[1],_rotationPos[2],_rotationPos[3]);
	}

	public function setParams(x:int, y:int):void {
		_posX = x;
		_posY = y;
	}

	public function setPuzzleId(id:uint):void {
		_puzzleId = id;
	}

	public function setVector4(value:Vector4):void {
		_rotationVector = value;
		_vector = _rotationVector.vector;
	}

	public function setRotate(value:Number):void {
		if(value != 0) {
			var num:Number = value / 90;
			for (var i:int = 0; i < num; i++) {
				_rotationVector.rotate();
			}
		}
		_rotateValue = value;
	}


	// properties

	public function get viewType():uint {	return _viewType;	}

	public function set viewType(value:uint):void {	_viewType = value;	}

	public function get havePrize():Boolean {	return _havePrize;	}

	public function set havePrize(value:Boolean):void {	_havePrize = value;	}

	public function get prizeId():uint {	return _prizeId;	}

	public function set prizeId(value:uint):void {	_prizeId = value;	}

	public function get activeStatus():Boolean {	return _activeStatus;	}

	public function set activeStatus(value:Boolean):void {	_activeStatus = value;	}

	public function get puzzleId():uint {	return _puzzleId;	}

	public function set puzzleId(value:uint):void {	_puzzleId = value;	}

	public function get rotateValue():Number {	return _rotateValue;	}

	public function set rotateValue(value:Number):void {	_rotateValue = value;	}

	public function get rotationPos():Array {	return _rotationPos;	}

	public function set rotationPos(value:Array):void {	_rotationPos = value;	}

	public function get rotationVector():Vector4 {	return _rotationVector;	}

	public function set rotationVector(value:Vector4):void {	_rotationVector = value;	}

	public function get vector():Array {	return _vector;	}

	public function set vector(value:Array):void {	_vector = value;	}

	public function get posX():int	{	return _posX	}

	public function get posY():int	{	return _posY;	}

	public function get open():Boolean {	return _open;	}

	public function set open(value:Boolean):void {	_open = value;	}

	public function set list(value:Array):void {	_list = value;	}

	public function get list():Array {
		if(!_list) {
			_list = [];
		}
		return _list;
	}

}
}
