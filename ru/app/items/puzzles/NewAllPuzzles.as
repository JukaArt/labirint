/**
 * Created by juka on 17.04.14.
 */
package ru.app.items.puzzles {
import com.greensock.TweenMax;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import ru.app.items.members.MemberController;

import ru.app.items.members.Members;

import ru.app.items.prize.PrizeController;

import ru.app.items.prize.Prizes;

import ru.core.Core;

public class NewAllPuzzles extends Sprite {

	public static const CONTAINER_POSX:Number = 50;
	public static const CONTAINER_POSY:Number = 50;
	private static const ACTIVE_POSX:Number = 900;
	private static const ACTIVE_POSY:Number = 150;
	private static const ITEM_SIZE:Number = 100;

	private var _allPuzzles:Vector.<PuzzleItem>;
	private var _container:Sprite;

	private var _prizes:Prizes;
	private var _members:Members;
	private var _prizeController:PrizeController;
	private var _memberController:MemberController;

	private var _memberElement:Array;
	private var _newElementId:uint;
	private var _animateCount:uint = 0;
	private var _currentPuzzle:uint = 0;

	public function NewAllPuzzles() {
		_allPuzzles = new Vector.<PuzzleItem>;
		_prizes = new Prizes();
		_members = new Members();

		_container = new Sprite();
		addChild(_container);
		addChild(_members);

		_container.x = CONTAINER_POSX;
		_container.y = CONTAINER_POSY;

		for (var i:int = 0; i < Core.instance.dataManager.game.allPuzzles.items.length; i++) {
			var item:PuzzleItem = new PuzzleItem();
			item.setParams(i);
			item.setId(i);
			_container.addChild(item);
			if(Core.instance.dataManager.game.allPuzzles.items.length - 1 != i) {
				item.x = 50 + 100 * int(i % 7);
				item.y = 50 + 100 * int(i / 7);
			} else {
				item.x = ACTIVE_POSX;
				item.y = ACTIVE_POSY;
				item.setActiveStatus(true);
			}
			Core.instance.eventManager.regEvent(item, MouseEvent.MOUSE_DOWN, itemMouseDownHandler);
			Core.instance.eventManager.regEvent(item, MouseEvent.CLICK, itemClickHandler);
			_allPuzzles.push(item);
		}

		_prizeController = new PrizeController(_prizes, _allPuzzles);
		_memberController = new MemberController(_members, null, _allPuzzles, null);

		setPrizes();
		setMembers();
	}

	// public

	public function startGame():void {

	}

	public function nextMemberHandler(e:Event = null):void {
		Core.instance.dataManager.game.apiLabirint.endMemeberMotionRequest(Core.instance.dataManager.game.gameId, Core.instance.dataManager.game.currentMember, completeEndMotionRequest);
	}

	public function rotatePuzzle(value:Number):void {
		_allPuzzles[_allPuzzles.length - 1].addRotate(value * 90);
	}

	// private

	private function setPrizes():void {
		addChild(_prizes);
		_prizeController.setPrizes();
	}

	private function setMembers():void {
		_memberController.setMemebers();
	}

	private function completeCheckPathRequest(array:Array):void {
		Core.instance.dataManager.game.path = [];

		if(array == null) {
			return;
		}

		for (var j:int = 0; j < array.length; j++) {
			for (var i:int = 0; i < _allPuzzles.length; i++) {
				if(_allPuzzles[i].puzzleId == array[j]) {
					Core.instance.dataManager.game.path.push(_allPuzzles[i]);
				}
			}
		}

//		if(Core.instance.dataManager.game.path.length != 0) {
//			dispatchEvent(new Event("moveMember"));
//		}
		_memberController.startMoveMember();
		Core.instance.eventManager.regEvent(_memberController, "nextMember", nextMemberHandler);
	}

	private function completeEndMotionRequest(num:Number):void {
		Core.instance.dataManager.game.currentMember = num;
		_currentPuzzle = _memberController.determinePuzzle(Core.instance.dataManager.game.currentMember - 1);

//		Core.instance.dataManager.game.apiLabirint.prizeTypeRequest(Core.instance.dataManager.game.gameId, Core.instance.dataManager.game.currentMember, 1, completePrizeRequest);
//		startGame();

	}

	private function completeMotionRequest(direction:Number):void {
		Core.instance.dataManager.game.direction = direction;
		var curPos:Number;
		var puzzle:PuzzleItem = _allPuzzles[_allPuzzles.length - 1];
		if (Core.instance.dataManager.game.direction < 3) {
			curPos = ITEM_SIZE + 50 + ((ITEM_SIZE * 2) * Core.instance.dataManager.game.direction);
			puzzle.y = -(ITEM_SIZE / 2);
			puzzle.x = curPos;
			moveElements(curPos, false, true);
		} else if (Core.instance.dataManager.game.direction >= 3 && Core.instance.dataManager.game.direction < 6) {
			curPos = ITEM_SIZE + 50 + ((ITEM_SIZE * 2) * (Core.instance.dataManager.game.direction - 3));
			puzzle.y = curPos;
			puzzle.x = -(ITEM_SIZE / 2);
			moveElements(curPos, true, true);
		} else if (Core.instance.dataManager.game.direction >= 6 && Core.instance.dataManager.game.direction < 9) {
			curPos = ITEM_SIZE + 50 + ((ITEM_SIZE * 2) * (Core.instance.dataManager.game.direction - 6));
			puzzle.y = curPos;
			puzzle.x = (ITEM_SIZE * 7) + (ITEM_SIZE / 2);
			moveElements(curPos, true, false);
		} else {
			curPos = ITEM_SIZE + 50 + ((ITEM_SIZE * 2) * (Core.instance.dataManager.game.direction - 9));
			puzzle.y = (ITEM_SIZE * 7) + 50;
			puzzle.x = curPos;
			moveElements(curPos, false, false);
		}
	}

	private function moveElements(curPos:Number, moveX:Boolean, addPxl:Boolean):void {
		var posY:Number = 0;
		_memberElement = [];
		for (var i:int = 0; i < _allPuzzles.length; i++) {
			var startPos:Number;
			var changePos:Number;
			if (moveX) {
				startPos = _allPuzzles[i].y;
				changePos = _allPuzzles[i].x;
			} else {
				startPos = _allPuzzles[i].x;
				changePos = _allPuzzles[i].y;
			}
			if (startPos == curPos) {
				if (i != _allPuzzles.length - 1 && addPxl) {
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
				if (_allPuzzles[i].memberOn) {
					_memberElement.push(_allPuzzles[i]);
					dispatchEvent(new Event("moveMember", true));
				}
				if (moveX) {

					if (!addPxl) {
						TweenMax.to(_allPuzzles[i], .3, {x: changePos - 100, onComplete: completeMoveAnimation});
					} else {
						TweenMax.to(_allPuzzles[i], .3, {x: changePos + 100, onComplete: completeMoveAnimation});
					}
				} else {
					if (!addPxl) {
						TweenMax.to(_allPuzzles[i], .3, {y: changePos - 100, onComplete: completeMoveAnimation});
					} else {
						TweenMax.to(_allPuzzles[i], .3, {y: changePos + 100, onComplete: completeMoveAnimation});
					}

				}
			}
		}
	}

	private function completeMoveAnimation():void {
		_animateCount++;
		if (_animateCount == 8) {
			_allPuzzles[_newElementId].x = ACTIVE_POSX;
			_allPuzzles[_newElementId].y = ACTIVE_POSY;

			var newElement:PuzzleItem = _allPuzzles[_newElementId];

			_allPuzzles[_allPuzzles.length - 1].setActiveStatus(false);
			_allPuzzles.splice(_newElementId, 1, _allPuzzles[_allPuzzles.length - 1]);
			_allPuzzles.splice(_allPuzzles.length - 1, 1);
			_allPuzzles[_newElementId].id = _newElementId;
			_allPuzzles.push(newElement);
			_allPuzzles[_allPuzzles.length - 1].setId(_allPuzzles.length - 1);
			_animateCount = 0;
		}
		Core.instance.eventManager.regEvent(_allPuzzles[_newElementId], MouseEvent.CLICK, itemClickHandler);
	}

	// handlers

	private function itemClickHandler(e:MouseEvent):void {
		trace("i clicked", e.currentTarget.puzzleId);
		var endPuzzleId:uint = e.currentTarget.puzzleId;
		Core.instance.dataManager.game.apiLabirint.cheсkPathRequest(Core.instance.dataManager.game.gameId, Core.instance.dataManager.game.playerId, _currentPuzzle, endPuzzleId, completeCheckPathRequest);
//		_currentPuzzle = endPuzzleId;

	}

	private function itemMouseDownHandler(e:MouseEvent):void {
		var id:uint = e.currentTarget.id;
		if (_allPuzzles[id].id == _allPuzzles.length - 1) {
			_container.addChild(_allPuzzles[id]);
			_allPuzzles[id].startDrag();
			Core.instance.dataManager.game.currentElement = _allPuzzles[id];
			dispatchEvent(new Event("startDragElement", true));
			Core.instance.eventManager.clearByCallback(_allPuzzles[id], itemClickHandler);
			Core.instance.eventManager.regEvent(_allPuzzles[id], MouseEvent.MOUSE_UP, itemMouseUpHandler);
		}
	}

	private function itemMouseUpHandler(e:MouseEvent):void {
		var id:uint = e.currentTarget.id;
		Core.instance.eventManager.clearByCallback(_allPuzzles[id], itemMouseUpHandler);
		if (_allPuzzles[id].id == _allPuzzles.length - 1) {
			_allPuzzles[id].stopDrag();
			dispatchEvent(new Event("stopDragElement", true));
			_allPuzzles[id].x = ACTIVE_POSX;
			_allPuzzles[id].y = ACTIVE_POSY;
			if (Core.instance.dataManager.game.wayChosen) {
				Core.instance.dataManager.game.apiLabirint.motionPuzzleRequest(Core.instance.dataManager.game.gameId, Core.instance.dataManager.game.playerId, Core.instance.dataManager.game.direction, completeMotionRequest);
			}
		}
	}










}
}
