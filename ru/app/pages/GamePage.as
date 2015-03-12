/**
 * Created by juka on 18.02.14.
 */
package ru.app.pages {
import flash.events.Event;
import flash.events.KeyboardEvent;

import ru.app.controls.RotatePanel;

import ru.app.items.cards.Cards;
import ru.app.items.puzzles.AllPuzzles;
import ru.app.items.members.Members;
import ru.app.items.movePlace.MovePlaces;
import ru.app.items.puzzles.ChangeablePuzzles;
import ru.app.items.puzzles.NewAllPuzzles;
import ru.core.Core;
import ru.core.view.primary.Page;

public class GamePage extends Page {

	public static const CARDS_POSX:Number = 900;
	public static const CARDS_POSY:Number = 400;

	private var _cards:Cards;
	private var _movePlaces:MovePlaces;
	private var _rotatePanel:RotatePanel;
	private var _newPuzzle:NewAllPuzzles;


	public function GamePage() {
		_rotatePanel = new RotatePanel();
		_movePlaces = new MovePlaces();
		_newPuzzle = new NewAllPuzzles();

		addChild(_rotatePanel);
		addChild(_movePlaces);
		addChild(_newPuzzle);

		_cards = new Cards();
		_cards.x = CARDS_POSX;
		_cards.y = CARDS_POSY;
		addChild(_cards);

		addListeners();
	}


	// private

	private function addListeners():void {
		Core.instance.eventManager.regEvent(_newPuzzle, "moveMember", moveMemberHandler);
		Core.instance.eventManager.regEvent(_rotatePanel, "leftRotate", leftRotateHandler);
		Core.instance.eventManager.regEvent(_rotatePanel, "rightRotate", rightRotateHandler);
		Core.instance.eventManager.regEvent(Core.instance.stage, KeyboardEvent.KEY_DOWN, keyDownHandler);
		Core.instance.eventManager.regEvent(_newPuzzle, "startDragElement", elementStartDragHandler, super.viewLabel);
		Core.instance.eventManager.regEvent(_newPuzzle, "stopDragElement", elementStopDragHandler, super.viewLabel);
	}


	private function startGame():void {
//		_puzzles.startGame();
	}

	// handlers

	private function moveMemberHandler(e:Event):void {
	}

	private function winPrizeHandler(e:Event):void {
		Core.instance.dataManager.game.openPrize++;
		if(Core.instance.dataManager.game.openPrize == 5) {
			Core.instance.dataManager.game.msgLine.setTextMessage("ВЫ ВЫИГРАЛИ");
			return;
		}
		Core.instance.dataManager.game.apiLabirint.prizeTypeRequest(Core.instance.dataManager.game.gameId, Core.instance.dataManager.game.playerId, Core.instance.dataManager.game.openPrize, completePrizeHandler);
	}

	private function completePrizeHandler(num:Number):void {
		Core.instance.dataManager.game.playerPrizes.push(num);
		_cards.cardClickHandler();
	}

	private function keyDownHandler(e:KeyboardEvent):void {
		if(e.charCode == 32) {
//			if(Core.instance.dataManager.game.path.length > 1) {
//				_puzzles.memberMotionRequest();
//			} else {
//				_puzzles.nextMemberHandler();
//			}
		}
	}

	private function rightRotateHandler(e:Event):void {
		_newPuzzle.rotatePuzzle(1);
	}

	private function leftRotateHandler(e:Event):void {
		_newPuzzle.rotatePuzzle(-1);
	}

	//handlers

	private function elementStopDragHandler(e:Event):void {
		_movePlaces.stopEnterFrame();
	}

	private function elementStartDragHandler(e:Event):void {
		_movePlaces.startEnterFrame();
	}


}
}
