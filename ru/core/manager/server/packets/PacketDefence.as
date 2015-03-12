/**
 * User: ilija
 * Date: 27.12.12
 * Time: 18:36
 */
package ru.core.manager.server.packets {

public class PacketDefence extends Packet {
	private var _id:uint;
	private var _ordinal:uint;
	private var _suit:uint;

	public function PacketDefence(id:uint, ordinal:uint, suit:uint) {
		super("DefendResult");

		_id = id;
		_ordinal = ordinal;
		_suit = suit;
	}

	override public function getData():String {
		var data:Object = {};
		data.type = _type;
		data.id = _id;

		data.moves = [];
		data.moves[0] = {};
		data.moves[0].ordinal = _ordinal;
		data.moves[0].suit = _suit;

		return JSON.stringify(data);
	}
}
}
