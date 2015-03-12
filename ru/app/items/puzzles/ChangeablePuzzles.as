/**
 * Created by juka on 08.04.14.
 */
package ru.app.items.puzzles {
import com.greensock.TweenMax;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import ru.core.Core;

public class ChangeablePuzzles extends Puzzle {

	private static const ACTIVE_POSX:Number = 900;
	private static const ACTIVE_POSY:Number = 150;
	private static const ITEM_SIZE:Number = 100;

	private var _memberElement:Array;
	private var _newElementId:uint;
	private var _animateCount:uint = 0;

	public function ChangeablePuzzles() {

		for (var i:int = 0; i < Core.instance.dataManager.game.allPuzzles.items.length; i++) {
			var item:PuzzleItem = new PuzzleItem();
			item.changeable = true;
			item.setParams(i);
			addChild(item);
			_items.push(item);
		}
		placeElements();
	}

	// private

	private function placeElements():void {
		var row:uint = 0;
		for (var l:int = 0; l < _items.length; l++) {
			var pos:Number = l % 10;
			if (l != _items.length - 1) {
				if (pos <= 2) {
					_items[l].x = _items[l].width + 50 + ((_items[l].width * 2) * pos);
					_items[l].y = (_items[l].height * row) + 50;
				} else {
					_items[l].x = 50 + ((_items[l].width) * (pos - 3));
					_items[l].y = (_items[l].height * row) + 50;
				}

				if (pos == 2 || pos == 9) {
					row++;
				}
			} else {
				_items[l].x = ACTIVE_POSX;
				_items[l].y = ACTIVE_POSY;
				_items[l].setActiveStatus(true);
			}

			Core.instance.eventManager.regEvent(_items[l], MouseEvent.MOUSE_DOWN, itemMouseDownHandler);
			Core.instance.eventManager.regEvent(_items[l], MouseEvent.CLICK, itemClickHandler);
		}
	}

	private function completeMotionRequest(direction:Number):void {
		Core.instance.dataManager.game.direction = direction;
		var curPos:Number;
		if (Core.instance.dataManager.game.direction < 3) {
			curPos = ITEM_SIZE + 50 + ((ITEM_SIZE * 2) * Core.instance.dataManager.game.direction);
			_items[_items.length - 1].y = -(ITEM_SIZE / 2);
			_items[_items.length - 1].x = curPos;
			moveElements(curPos, false, true);
		} else if (Core.instance.dataManager.game.direction >= 3 && Core.instance.dataManager.game.direction < 6) {
			curPos = ITEM_SIZE + 50 + ((ITEM_SIZE * 2) * (Core.instance.dataManager.game.direction - 3));
			_items[_items.length - 1].y = curPos;
			_items[_items.length - 1].x = -(ITEM_SIZE / 2);
			moveElements(curPos, true, true);
		} else if (Core.instance.dataManager.game.direction >= 6 && Core.instance.dataManager.game.direction < 9) {
			curPos = ITEM_SIZE + 50 + ((ITEM_SIZE * 2) * (Core.instance.dataManager.game.direction - 6));
			_items[_items.length - 1].y = curPos;
			_items[_items.length - 1].x = (ITEM_SIZE * 7) + (ITEM_SIZE / 2);
			moveElements(curPos, true, false);
		} else {
			curPos = ITEM_SIZE + 50 + ((ITEM_SIZE * 2) * (Core.instance.dataManager.game.direction - 9));
			_items[_items.length - 1].y = (ITEM_SIZE * 7) + 50;
			_items[_items.length - 1].x = curPos;
			moveElements(curPos, false, false);
		}

	}


	private function moveElements(curPos:Number, moveX:Boolean, addPxl:Boolean):void {
		var posY:Number = 0;
		_memberElement = [];
		for (var i:int = 0; i < _items.length; i++) {
			var startPos:Number;
			var changePos:Number;
			if (moveX) {
				startPos = _items[i].y;
				changePos = _items[i].x;
			} else {
				startPos = _items[i].x;
				changePos = _items[i].y;
			}
			if (startPos == curPos) {
				if (i != _items.length - 1 && addPxl) {
					if (changePos > posY) {
						_newElementId = i;
						posY = changePos;
					}

				} else {
					if (!addPxl) {
						if (changePos == 50) {
							_newElementId = i;
						}
					}
				}
				if (_items[i].memberOn) {
					_memberElement.push(_items[i]);
					dispatchEvent(new Event("moveMember", true));
				}
				if (moveX) {

					if (!addPxl) {
						TweenMax.to(_items[i], .3, {x: changePos - 100, onComplete: completeMoveAnimation});
					} else {
						TweenMax.to(_items[i], .3, {x: changePos + 100, onComplete: completeMoveAnimation});
					}
				} else {
					if (!addPxl) {
						TweenMax.to(_items[i], .3, {y: changePos - 100, onComplete: completeMoveAnimation});
					} else {
						TweenMax.to(_items[i], .3, {y: changePos + 100, onComplete: completeMoveAnimation});
					}

				}
			}
		}
	}

	private function completeMoveAnimation():void {
		_animateCount++;
		if (_animateCount == 8) {
			_items[_newElementId].x = ACTIVE_POSX;
			_items[_newElementId].y = ACTIVE_POSY;

			var newElement:PuzzleItem = _items[_newElementId];

			_items[_items.length - 1].setActiveStatus(false);
			_items.splice(_newElementId, 1, _items[_items.length - 1]);
			_items.splice(_items.length - 1, 1);
			_items[_newElementId].id = _newElementId;
			_items.push(newElement);
			_items[_items.length - 1].setId(_items.length - 1);
			_animateCount = 0;
		}
	}



	public function rotatePuzzle(value:Number):void {
		_items[_items.length - 1].addRotate(value * 90);
		sendRotateRequest();
	}

	private function sendRotateRequest():void {
		var rotation:Number = _items[_items.length - 1].puzzleRotate;
		var rotationVector:Array = _items[_items.length - 1].vector.vector;
		Core.instance.dataManager.game.apiLabirint.rotatePuzzleRequest(Core.instance.dataManager.game.gameId, Core.instance.dataManager.game.playerId, _items[_items.length - 1].puzzleId, rotation, rotationVector, completeRotationRequest);
	}

	private function completeRotationRequest():void {

	}


	// handlers

	private function itemMouseDownHandler(e:MouseEvent):void {
		var id:uint = e.currentTarget.id;
		if (_items[id].id == _items.length - 1) {
			addChild(_items[id]);
			_items[id].startDrag();
			Core.instance.dataManager.game.currentElement = _items[id];
			dispatchEvent(new Event("startDragElement", true));
			Core.instance.eventManager.regEvent(_items[id], MouseEvent.MOUSE_UP, itemMouseUpHandler);
		}
	}

	private function itemMouseUpHandler(e:MouseEvent):void {
		var id:uint = e.currentTarget.id;
		Core.instance.eventManager.clearByCallback(_items[id], itemMouseUpHandler);
		if (_items[id].id == _items.length - 1) {
			_items[id].stopDrag();
			dispatchEvent(new Event("stopDragElement", true));
			_items[id].x = ACTIVE_POSX;
			_items[id].y = ACTIVE_POSY;
			if (Core.instance.dataManager.game.wayChosen) {
				Core.instance.dataManager.game.apiLabirint.motionPuzzleRequest(Core.instance.dataManager.game.gameId, Core.instance.dataManager.game.playerId, Core.instance.dataManager.game.direction, completeMotionRequest);
			}
		}
	}


	//properties

	public function get memberElement():Array {
		return _memberElement;
	}

	public function set memberElement(value:Array):void {
		_memberElement = value;
	}
}
}
