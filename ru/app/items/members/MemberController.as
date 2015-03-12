/**
 * Created by juka on 14.04.14.
 */
package ru.app.items.members {

import com.greensock.TweenMax;

import flash.events.Event;

import flash.events.EventDispatcher;

import ru.app.items.puzzles.ChangeablePuzzles;

import ru.app.items.puzzles.PrimePuzzles;
import ru.app.items.puzzles.PuzzleItem;
import ru.core.Core;

public class MemberController extends EventDispatcher{

	private var _members:Members;
	private var _primePuzzle:PrimePuzzles;
	private var _allPuzzles:Vector.<PuzzleItem>;
	private var _changeableElements:ChangeablePuzzles;

	public function MemberController(members:Members, prime:PrimePuzzles, allPuzzles:Vector.<PuzzleItem>, changeableElements:ChangeablePuzzles) {
		_members = members;
		_primePuzzle = prime;
		_allPuzzles = allPuzzles;
		_changeableElements = changeableElements;
	}

	public function setMemebers():void {
		setMemberItem(0, 0);
		setMemberItem(1, 6);
		setMemberItem(2, 42);
		setMemberItem(3, 48);
		_members.items[Core.instance.dataManager.game.playerId - 1].setUser(true);
	}

	private function setMemberItem(num1:Number, num2:Number):void {
		_members.items[num1].x = _allPuzzles[num2].x + 50;
		_members.items[num1].y = _allPuzzles[num2].y + 50;
	}


	public function startMoveMember(data:Object = null):void {
//		Core.instance.dataManager.game.path = [];
//		Core.instance.dataManager.game.pathPuzzles.setData(data.path);

//		for (var i:int = 0; i < Core.instance.dataManager.game.pathPuzzles.items.length; i++) {
//			if(Core.instance.dataManager.game.pathPuzzles.items[i].changeable) {
//				for (var l:int = 0; l < _allPuzzles.length; l++) {
//					if(_allPuzzles[l].changeable) {
//						if(Core.instance.dataManager.game.pathPuzzles.items[i].puzzleId == _allPuzzles[l].puzzleId) {
//							Core.instance.dataManager.game.path.push(_allPuzzles[l]);
//						}
//					}
//				}
//			} else {
//				for (var k:int = 0; k < _allPuzzles.length; k++) {
//					if(!_allPuzzles[k].changeable) {
//						if(Core.instance.dataManager.game.pathPuzzles.items[i].puzzleId == _allPuzzles[k].id) {
//							Core.instance.dataManager.game.path.push(_allPuzzles[k]);
//						}
//					}
//				}
//			}
//		}

		moveMember(1, Core.instance.dataManager.game.path);
	}

	public function moveMember(value:uint, obj:*):void {
		if(value != obj.length) {
			TweenMax.to(_members.items[Core.instance.dataManager.game.currentMember - 1], 0.3, {x: obj[value].x + 50, y: obj[value].y + 50, onComplete:moveAgain, onCompleteParams: [value + 1 , obj]});
		} else {
			if(Core.instance.dataManager.game.path[Core.instance.dataManager.game.path.length - 1].havePrize){
				if(Core.instance.dataManager.game.myMotion) {
					if(Core.instance.dataManager.game.path[Core.instance.dataManager.game.path.length - 1].prizeId == Core.instance.dataManager.game.playerPrizes[Core.instance.dataManager.game.playerPrizes.length - 1]) {
						dispatchEvent(new Event("winPrize"));
					}
				} else {

				}

			}
			dispatchEvent(new Event("nextMember"));
			_members.setActive();
		}
	}

	public function determinePuzzle(id:uint):Number {
		var puzzleId:Number;
		for (var i:int = 0; i < _allPuzzles.length; i++) {
			if(_members.items[id].x == _allPuzzles[i].x + 50 && _members.items[id].y == _allPuzzles[i].y + 50) {
				puzzleId = _allPuzzles[i].puzzleId;
			}
		}

		return puzzleId;
	}


	private function moveAgain(value:uint, obj:*):void {
		moveMember(value, obj);
	}

	public function memeberOutOfField():void {
		for (var i:int = 0; i < _members.items.length; i++) {
			for (var j:int = 0; j < _changeableElements.memberElement.length; j++) {
				if(_changeableElements.memberElement[j].x == _members.items[i].x - 50 && _changeableElements.memberElement[j].y == _members.items[i].y - 50) {
					if(Core.instance.dataManager.game.direction < 3) {
						moveMemeberOnElement(_members.items[i], 700, 0, 1, false);
					} else if(Core.instance.dataManager.game.direction >= 3 && Core.instance.dataManager.game.direction < 6) {
						moveMemeberOnElement(_members.items[i], 700, 0, 1, true);
					} else if(Core.instance.dataManager.game.direction >= 6 && Core.instance.dataManager.game.direction < 9) {
						moveMemeberOnElement(_members.items[i], 100, 800, -1, true);
					} else {
						moveMemeberOnElement(_members.items[i], 100, 800, -1, false);
					}
				}

			}
		}
	}

	private function moveMemeberOnElement(obj:*, value1:Number, value2:Number,  num:Number, moveX:Boolean):void {
		if(moveX) {
			if(obj.x == value1) {
				obj.x = value2;
			}
			TweenMax.to(obj, .3, {x: obj.x + (100 * num)});
		} else {
			if(obj.y == value1) {
				obj.y = value2;
			}
			TweenMax.to(obj, .3, {y: obj.y + (100 * num)});
		}

	}

}
}
