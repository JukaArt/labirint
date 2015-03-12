/**
 * User: ilija
 * Date: 25.12.12
 * Time: 13:55
 */
package ru.core.manager.server {

import ru.core.Core;

public class PacketManager {

	private var _initComplete:Function;
	private var _timeOut:Function;
	private var _startGame:Function;

	private var _attackResult:Function;
	private var _defenceResult:Function;
	private var _throwResult:Function;

	private var _startAttack:Function;
	private var _startDefence:Function;
	private var _startThrow:Function;

	private var _bita:Function;
	private var _takeCards:Function;
	private var _cards:Function;

	private var _pass:Function;

	private var _endGame:Function;

	public function PacketManager() {

	}

	public function translate(message:String):void {

		try {
			// some code that could throw an error
			var data:Object = JSON.parse(message);
		}
		catch (err:Error) {
			return;
		}

		if (Core.instance.settings.debug)
			Core.instance.uiManager.debugContainer.showTrace(message);

		trace("PACKET: " + message);

		if(data == true)
			return;

		switch (data.type) {
			case "InitComplete" :
				if (_initComplete != null)
					_initComplete(data.timeout);
				break;
			case "Timeout" :
				if (_timeOut != null)
					_timeOut(data.value);
				break;
			case "StartGame" :
				if (_startGame != null)
					_startGame(data);
				break;
			case "AttackStart" :
				if (_startAttack != null)
					_startAttack(data.id);
				break;
			case "DefendStart" :
				if (_startDefence != null)
					_startDefence(data.id, "defence");
				break;
			case "StartTakeCards":
				if (_startThrow != null)
					_startThrow(data.id, "throw");
				break;
			case "AttackResult" :
				if (_attackResult != null)
					_attackResult(data);
				break;
			case "DefendResult" :
				if (_defenceResult != null)
					_defenceResult(data);
				break;
			case "Cards" :
				if (_cards != null)
					_cards(data);
				break;
			case "TakeCards" :
				if (_takeCards != null)
					_takeCards(data);
				break;
			case "PassTakeCards":
				if (_pass != null)
					_pass(data.id);
				break;
			case "ResultTakeCards":
				if (_throwResult != null)
					_throwResult(data);
				break;
			case "Pass" :
				if (_pass != null)
					_pass(data.id);
				break;
			case "Bita" :
				if (_bita != null)
					_bita();
				break;
			case "EndGame" :
				if (_endGame != null)
					_endGame(data.id);
				break;
		}
	}


	// properties
	public function set initComplete(value:Function):void { _initComplete = value; }

	public function set timeOut(value:Function):void { _timeOut = value; }

	public function set startGame(value:Function):void { _startGame = value; }

	public function set attackResult(value:Function):void { _attackResult = value; }

	public function set defenceResult(value:Function):void { _defenceResult = value; }

	public function set startAttack(value:Function):void { _startAttack = value; }

	public function set startDefence(value:Function):void { _startDefence = value; }

	public function set bita(value:Function):void { _bita = value; }

	public function set takeCards(value:Function):void { _takeCards = value; }

	public function set cards(cards:Function):void { _cards = cards; }

	public function set pass(value:Function):void { _pass = value; }

	public function set endGame(value:Function):void { _endGame = value; }

	public function set startThrow(value:Function):void { _startThrow = value; }

	public function set throwResult(value:Function):void { _throwResult = value; }
}
}
