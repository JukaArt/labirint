/**
 * Created by juka on 27.02.14.
 */
package ru.app.items.puzzles {
import flash.display.Sprite;
import flash.events.Event;

import lib.GoButtonUI;

import ru.app.items.BotController;
import ru.app.items.members.MemberController;
import ru.app.items.members.Members;
import ru.app.items.prize.PrizeController;
import ru.app.items.prize.Prizes;
import ru.core.Core;

public class AllPuzzles extends Sprite {

	public static const CONTAINER_POSX:Number = 50;
	public static const CONTAINER_POSY:Number = 50;


	private var _elementsContainer:Sprite;

	private var _primeElements:PrimePuzzles;
	private var _changeableElements:ChangeablePuzzles;
	private var _allPuzzles:Vector.<PuzzleItem>;

	private var _prizes:Prizes;
	private var _members:Members;

	// controllers
	private var _botController:BotController;
	private var _memberController:MemberController;
	private var _puzzleController:PuzzleController;
	private var _prizeController:PrizeController;


	public function AllPuzzles() {
		Core.instance.dataManager.game.path = [];
		_members = new Members();
		_prizes = new Prizes();
		_elementsContainer = new Sprite();
		_primeElements = new PrimePuzzles();
		_changeableElements = new ChangeablePuzzles();


		addChild(_elementsContainer);
		addChild(_members);

		_elementsContainer.addChild(_primeElements);
		_elementsContainer.addChild(_changeableElements);

		_elementsContainer.x = CONTAINER_POSX;
		_elementsContainer.y = CONTAINER_POSY;

		_allPuzzles = new Vector.<PuzzleItem>;
		addPuzzles(_primeElements.items);
		addPuzzles(_changeableElements.items);

		// initializing controllers

		_prizeController = new PrizeController(_prizes, _allPuzzles);
		_botController = new BotController(_allPuzzles, _members);
		_puzzleController = new PuzzleController(_allPuzzles, _members);
		_memberController = new MemberController(_members, _primeElements, _allPuzzles, _changeableElements);

		setPrizes();
		setMembers();

		Core.instance.eventManager.regEvent(_changeableElements, "moveMember", moveMemberHandler);
	}

	// public

	public function startGame():void {
		Core.instance.dataManager.game.myMotion = Core.instance.dataManager.game.currentMember == Core.instance.dataManager.game.playerId;
		Core.instance.dataManager.game.path = [];

		_puzzleController.setStartPosition();
		_puzzleController.setElementMemberOn();

		if (!Core.instance.dataManager.game.myMotion) {
			Core.instance.dataManager.game.botPath = [];
		}
	}

	private function setMembers():void {
		_memberController.setMemebers();
		Core.instance.eventManager.regEvent(_memberController, "nextMember", nextMemberHandler);
		Core.instance.eventManager.regEvent(_memberController, "winPrize", winPrizeMemberHandler);
	}

	private function winPrizeMemberHandler(e:Event):void {
		dispatchEvent(new Event("winPrize"));
	}

	public function memberMotionRequest():void {
		var pathData:Object = new Object();
		var puzzleIdArray:Array = [];

		for (var i:int = 0; i < Core.instance.dataManager.game.path.length; i++) {
			var data:Object = new Object();
			data.changeable = Core.instance.dataManager.game.path[i].changeable;

			if (Core.instance.dataManager.game.path[i].changeable) {
				data.puzzleId = Core.instance.dataManager.game.path[i].puzzleId;
			} else {
				data.puzzleId = Core.instance.dataManager.game.path[i].id;
			}
			puzzleIdArray.push(data);
		}

		pathData.path = puzzleIdArray;

		Core.instance.dataManager.game.apiLabirint.motionMemberRequest(Core.instance.dataManager.game.gameId, Core.instance.dataManager.game.playerId, pathData, completeMemberMotionRequest);
	}

	private function completeMemberMotionRequest(path:Object):void {
		_memberController.startMoveMember(path);

	}

	public function nextMemberHandler(e:Event = null):void {
		Core.instance.dataManager.game.apiLabirint.endMemeberMotionRequest(Core.instance.dataManager.game.gameId, Core.instance.dataManager.game.currentMember, completeEndMotionRequest);
	}

	private function completeEndMotionRequest(num:Number):void {
		Core.instance.dataManager.game.currentMember = num;
		_puzzleController.resetPuzzles();
		Core.instance.dataManager.game.apiLabirint.prizeTypeRequest(Core.instance.dataManager.game.gameId, Core.instance.dataManager.game.currentMember, 1, completePrizeRequest);
		startGame();
	}

	private function completePrizeRequest(num:Number):void {
	}

	// prizes  setting

	private function setPrizes():void {
		addChild(_prizes);
		_prizeController.setPrizes();
	}

	// puzzles setting

	private function addPuzzles(vector:Vector.<PuzzleItem>):void {
		for (var i:int = 0; i < vector.length; i++) {
			_allPuzzles.push(vector[i]);
		}
	}

	public function rotatePuzzle(value:Number):void {
		_changeableElements.rotatePuzzle(value);
	}


	// handlers

	private function moveMemberHandler(e:Event):void {
		_memberController.memeberOutOfField();
		_puzzleController.setElementMemberOn();
	}


}
}
