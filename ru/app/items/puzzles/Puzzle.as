/**
 * Created by juka on 14.04.14.
 */
package ru.app.items.puzzles {
import flash.display.Sprite;
import flash.events.MouseEvent;

import ru.core.Core;

public class Puzzle extends Sprite{

	private static const ITEM_SIZE:Number = 100;

	protected var _items:Vector.<PuzzleItem>;

	public function Puzzle() {
		_items = new Vector.<PuzzleItem>;

	}


	private function rightWay(id:uint, num1:Number, num2:Number):Boolean {
		var num:Number = Core.instance.dataManager.game.path.length;
		return _items[id].vector.vector[num1] == 1 && Core.instance.dataManager.game.path[num - 1].vector.vector[num2] == 1;
	}

	protected function itemClickHandler(e:MouseEvent):void {
		var id:Number = e.currentTarget.id;
		var num:Number = Core.instance.dataManager.game.path.length;
		if(num != 0) {
			var posX:Number = Core.instance.dataManager.game.path[num - 1].x - _items[id].x;
			var posY:Number = Core.instance.dataManager.game.path[num - 1].y - _items[id].y;
			if((Math.abs(posX) == ITEM_SIZE &&  Math.abs(posY) == 0) || (Math.abs(posX) == 0 &&  Math.abs(posY) == ITEM_SIZE)) {
				var canMove:Boolean;
				if(posX == ITEM_SIZE) {
					canMove = rightWay(id, 1, 3);
				} else if (posX == -ITEM_SIZE) {
					canMove = rightWay(id, 3, 1);
				} else if(posY == -ITEM_SIZE) {
					canMove = rightWay(id, 0, 2);
				} else if (posY == ITEM_SIZE) {
					canMove = rightWay(id, 2, 0);
				}

				if(canMove) {
					_items[id].uiClickHandler();
					Core.instance.dataManager.game.path.push(_items[id]);
				}

			}
		} else {
			if(id != _items.length - 1) {
				_items[id].uiClickHandler();
				Core.instance.dataManager.game.path.push(_items[id]);
			}
		}

	}


	//

	public function get items():Vector.<PuzzleItem> {
		return _items;
	}

	public function set items(value:Vector.<PuzzleItem>):void {
		_items = value;

}
}
}
