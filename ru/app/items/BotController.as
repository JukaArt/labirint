/**
 * Created by juka on 14.04.14.
 */
package ru.app.items {
import ru.app.items.members.Members;
import ru.app.items.puzzles.PuzzleItem;
import ru.core.Core;

public class BotController {

	private var _members:Members;
	private var _allPuzzles:Vector.<PuzzleItem>;

	public function BotController(allPuzzles:Vector.<PuzzleItem>, members:Members) {
		_members = members;
		_allPuzzles = allPuzzles;
	}

	public function createBotPath():void {
		for (var i:int = 0; i < _allPuzzles.length; i++) {
			if(_members.items[Core.instance.dataManager.game.currentMember - 1].x - 50 == _allPuzzles[i].x && _members.items[Core.instance.dataManager.game.currentMember - 1].y - 50 == _allPuzzles[i].y) {
				Core.instance.dataManager.game.botPath.push(_allPuzzles[i]);
			}
		}

//		botMove();
	}

	private function botMove():void {
		var length:Number = Core.instance.dataManager.game.botPath.length - 1;
		for (var i:int = 0; i < _allPuzzles.length; i++) {
			if(Core.instance.dataManager.game.botPath[length].x -100 == _allPuzzles[i].x && Core.instance.dataManager.game.botPath[length].y  == _allPuzzles[i].y) {
				addSteptoBotPath(_allPuzzles[i]);
				return;
			} else if(Core.instance.dataManager.game.botPath[length].x  == _allPuzzles[i].x && Core.instance.dataManager.game.botPath[length].y - 100 == _allPuzzles[i].y) {
				addSteptoBotPath(_allPuzzles[i]);
				return;
			} else if(Core.instance.dataManager.game.botPath[length].x + 100 == _allPuzzles[i].x && Core.instance.dataManager.game.botPath[length].y  == _allPuzzles[i].y) {
				addSteptoBotPath(_allPuzzles[i]);
				return;
			} else if(Core.instance.dataManager.game.botPath[length].x == _allPuzzles[i].x && Core.instance.dataManager.game.botPath[length].y + 100 == _allPuzzles[i].y) {
				addSteptoBotPath(_allPuzzles[i]);
				return;
			} else {

			}
		}
	}

	private function rightWay(id:uint, num1:Number, num2:Number):Boolean {
		var num:Number = Core.instance.dataManager.game.botPath.length;
		return _allPuzzles[id].vector.vector[num1] == 1 && Core.instance.dataManager.game.botPath[num - 1].vector.vector[num2] == 1;
	}

	private function addSteptoBotPath(obj:*):void {
		var num:Number = Core.instance.dataManager.game.botPath.length;
		var posX:Number = Core.instance.dataManager.game.botPath[num - 1].x - obj.x;
		var posY:Number = Core.instance.dataManager.game.botPath[num - 1].y - obj.y;

		var canMove:Boolean;
		if (posX == 100) {
			canMove = rightWay(obj.id, 1, 3);
		} else if (posX == -100) {
			canMove = rightWay(obj.id, 3, 1);
		} else if (posY == -100) {
			canMove = rightWay(obj.id, 0, 2);
		} else if (posY == 100) {
			canMove = rightWay(obj.id, 2, 0);
		}

//		trace("CAN MOVE", canMove);
		if(canMove) {
			Core.instance.dataManager.game.botPath.push(obj);
			botMove();
		} else {
			for (var i:int = 0; i < Core.instance.dataManager.game.botPath.length; i++) {

			}
		}
	}
}
}
