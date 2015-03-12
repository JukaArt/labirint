/**
 * Created by juka on 26.02.14.
 */
package ru.app.items.cards {
import flash.display.Sprite;
import flash.events.MouseEvent;

import lib.CardUI;

import ru.app.items.prize.PrizeItem;
import ru.app.items.prize.Prizes;

import ru.core.Core;

public class Cards extends Sprite {

	private static const POS_X:Number = 50;
	private static const POS_Y:Number = 200;

	private var _openCards:Vector.<CardItem>;
	private var _openPrizes:Vector.<PrizeItem>;

	private var _prizes:Prizes;

	public function Cards() {

		_openCards = new Vector.<CardItem>;
		_openPrizes = new Vector.<PrizeItem>;

		_prizes = new Prizes();

		cardClickHandler();
//		Core.instance.eventManager.regEvent(_card, MouseEvent.CLICK, cardClickHandler);
	}

	//private


	private function placeCard():void {
		for (var i:int = 0; i < _openCards.length; i++) {
			_openCards[i].x = POS_X * i;
			_openCards[i].y = POS_Y;
		}
		Core.instance.dataManager.game.currentTaskPrize = _openCards[_openCards.length - 1].id;
	}


	// handlers

	public function cardClickHandler(e:MouseEvent = null):void {
		if(_openCards.length != Core.instance.dataManager.game.userPrizesAmount) {
			var item:CardItem = new CardItem();
			addChild(item);
			_openCards.push(item);
			var prize:PrizeItem = new PrizeItem();
			prize.setView(Core.instance.dataManager.game.playerPrizes[Core.instance.dataManager.game.playerPrizes.length - 1]);
			item.setPrize(prize);
			placeCard();
		}
	}

}
}
