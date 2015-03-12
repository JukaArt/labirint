/**
 * Created by juka on 14.04.14.
 */
package ru.app.items.prize {
import flash.events.EventDispatcher;

import ru.app.items.puzzles.PuzzleItem;
import ru.core.Core;

public class PrizeController extends EventDispatcher{

	private var _prizes:Prizes;
	private var _allPuzzles:Vector.<PuzzleItem>;

	public function PrizeController(prizes:Prizes, allPuzzles:Vector.<PuzzleItem>) {
		_prizes = prizes;
		_allPuzzles = allPuzzles;
	}

	public function setPrizes():void {
		for (var i:int = 0; i < _allPuzzles.length; i++) {
			if (Core.instance.dataManager.game.puzzlePrizes.items[i].havePrize) {
				_allPuzzles[i].setPrize(_prizes.prizes[i]);
			}
		}
	}
}
}
