package {

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.events.Event;

import ru.app.AppSettings;

import ru.core.Core;
import ru.core.manager.Settings;

[SWF(width=1200, height=800, backgroundColor=0x334770)]

public class Labirint extends Sprite {

    public function Labirint() {
		(stage) ? init() : addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
    }

	private function init(event:Event = null):void {
		stage.align = StageAlign.TOP_LEFT;
		Core.instance.init(stage, new AppSettings(), setupComplete); // !IMPORTANT
	}

	private function setupComplete():void {

		Core.instance.dataManager.game.apiLabirint.initRequest(completeInitRequest);
	}

	private function completeInitRequest(data:Object):void {
		Core.instance.dataManager.game.allPuzzles.setData(data.puzzles);
		Core.instance.dataManager.game.puzzlePrizes.setData(data.prizes);
		Core.instance.dataManager.game.cardsId.push(data.firstPrizeId);
		Core.instance.dataManager.game.playerId = data.id;
		Core.instance.dataManager.game.gameId = data.gameId;
		Core.instance.dataManager.game.openPrize = 0;

		Core.instance.dataManager.game.apiLabirint.prizeTypeRequest(Core.instance.dataManager.game.gameId, Core.instance.dataManager.game.playerId, Core.instance.dataManager.game.openPrize, completePrizeRequest);
	}

	private function completePrizeRequest(num:Number):void {
		Core.instance.dataManager.game.playerPrizes.push(num);
		Core.instance.uiManager.showPage(Settings.GAME_PAGE);
	}
}
}
