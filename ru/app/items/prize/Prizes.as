/**
 * Created by juka on 27.02.14.
 */
package ru.app.items.prize {
import flash.display.Sprite;

import ru.core.Core;

public class Prizes extends Sprite {

	private var _prizes:Vector.<PrizeItem>;
	private var _prizeType:Array;

	public function Prizes() {
		_prizes = new Vector.<PrizeItem>;

		for (var i:int = 0; i < Core.instance.dataManager.game.puzzlePrizes.items.length; i++) {
			var item:PrizeItem = new PrizeItem();
			if(Core.instance.dataManager.game.puzzlePrizes.items[i].havePrize) {
				item.setView(Core.instance.dataManager.game.puzzlePrizes.items[i].prizeId);
			}

			_prizes.push(item);
		}
	}

	public function get prizes():Vector.<PrizeItem> {
		return _prizes;
	}

	public function set prizes(value:Vector.<PrizeItem>):void {
		_prizes = value;
	}
}
}
