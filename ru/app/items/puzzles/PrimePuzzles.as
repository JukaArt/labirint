/**
 * Created by juka on 18.02.14.
 */
package ru.app.items.puzzles {
import flash.events.MouseEvent;

import ru.core.Core;

public class PrimePuzzles extends Puzzle {

	private var _rotations:Array;

	private static const ITEM_SIZE:Number = 100;


	public function PrimePuzzles() {

		_rotations = [0, 90, 90, 90, 0, 0, 0, 180, 0, 270, 180, 180, 270, 270, 270, 180];

		for (var i:int = 0; i < Core.instance.dataManager.game.primePuzzlesAmount; i++) {
			var item:PuzzleItem = new PuzzleItem();
			item.changeable = false;
			item.setId(i);

			if (i == 0 || i == 3 || i == 12 || i == 15) {
				item.chooseView(3);
			} else {
				item.chooseView(2);
			}

			item.rotateElement(_rotations[i]);
			item.x = 50 + ((item.width * 2) * int(i % 4));
			item.y = 50 + ((item.width * 2) * int(i / 4));
			addChild(item);

			Core.instance.eventManager.regEvent(item, MouseEvent.CLICK, itemClickHandler);
			_items.push(item);
		}
	}
}
}
