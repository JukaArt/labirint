/**
 * Created by juka on 14.04.14.
 */
package ru.app.items.puzzles {
import flash.events.EventDispatcher;

import ru.app.items.members.Members;
import ru.core.Core;

public class PuzzleController extends EventDispatcher{

	private var _members:Members;
	private var _allPuzzles:Vector.<PuzzleItem>;

	public function PuzzleController(allPuzzles:Vector.<PuzzleItem>, members:Members) {
		_allPuzzles = allPuzzles;
		_members = members;
	}

	public function setStartPosition():void {
		for (var i:int = 0; i < _allPuzzles.length; i++) {
			if(_members.items[Core.instance.dataManager.game.currentMember - 1].x - 50 == _allPuzzles[i].x && _members.items[Core.instance.dataManager.game.currentMember - 1].y - 50 == _allPuzzles[i].y) {
				Core.instance.dataManager.game.path.push(_allPuzzles[i]);
				_allPuzzles[i].uiClickHandler();
				_allPuzzles[i].memberOn = true;
			}
		}
	}

	public function setElementMemberOn():void {
		for (var i:int = 0; i < _allPuzzles.length; i++) {
			for (var j:int = 0; j < _members.items.length; j++) {
				if(_members.items[j].x - 50 == _allPuzzles[i].x && _members.items[j].y - 50 == _allPuzzles[i].y) {
					_allPuzzles[i].memberOn = true;
				}
			}
		}
	}

	public function resetPuzzles():void {
		for (var i:int = 0; i < _allPuzzles.length; i++) {
			_allPuzzles[i].resetElement();
		}
	}

}
}
