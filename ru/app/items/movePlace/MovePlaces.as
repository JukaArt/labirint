/**
 * Created by juka on 28.02.14.
 */
package ru.app.items.movePlace {
import flash.display.Sprite;
import flash.events.Event;

import ru.core.Core;

public class MovePlaces extends Sprite {

	public static const CONTAINER_POSX:Number = 50;
	public static const CONTAINER_POSY:Number = 50;

	private var _items:Vector.<MovePlaceItem>;
	private var _itemContainer:Sprite;

	public function MovePlaces() {
		_itemContainer = new Sprite();
		_items = new Vector.<MovePlaceItem>;

		_itemContainer.x = CONTAINER_POSX;
		_itemContainer.y = CONTAINER_POSY;
		addChild(_itemContainer);

		for (var i:int = 0; i < Core.instance.dataManager.game.movePlaceAmount; i++) {
			var item:MovePlaceItem = new MovePlaceItem();
			_itemContainer.addChild(item);
			if(i < 3) {
				item.rotateUI(-90);
				item.x = (item.width * 1.5) + ((item.width * 2) * i);
				item.y = - (item.height / 2);
			} if(i >= 3 && i < 6) {
				item.rotateUI(180);
				item.x = - (item.width / 2);
				item.y = (item.height * 1.5) + ((item.height * 2) * (i - 3));
			} if (i >= 6 && i < 9) {
				item.x = 707 + (item.width / 2);
				item.y = (item.height * 1.5) + ((item.height * 2 + 3) * (i - 6));
			} else if(i >= 9 && i < Core.instance.dataManager.game.movePlaceAmount){
				item.rotateUI(90);
				item.y = 707 + (item.height / 2);
				item.x = (item.width * 1.5) + ((item.width * 2) * (i - 9));
			}

			_items.push(item);
		}
	}

	public function startEnterFrame():void {
		Core.instance.eventManager.regEvent(this, Event.ENTER_FRAME, enterFrameHandler);
	}

	public function stopEnterFrame():void {
		for (var i:int = 0; i < _items.length; i++) {
			_items[i].uiRollOutHandler();
		}
		Core.instance.eventManager.clearByCallback(this, enterFrameHandler);
	}

	// handlers



	private function enterFrameHandler(e:Event):void {
		var num:Number = 0;

		for (var i:int = 0; i < _items.length; i++) {
			if(_items[i].hitTestObject(Core.instance.dataManager.game.currentElement)) {
				Core.instance.dataManager.game.direction = i;
				_items[i].uiRollOverHandler();
				num++;
			} else {
				_items[i].uiRollOutHandler();
			}
		}
		Core.instance.dataManager.game.wayChosen = num != 0;

	}

}
}
