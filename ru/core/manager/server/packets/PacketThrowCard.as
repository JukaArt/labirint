/**
 * User: ilija
 * Date: 30.01.13
 * Time: 9:02
 */
package ru.core.manager.server.packets {

public class PacketThrowCard extends Packet {

	private var _id:uint;
	private var _ordinal:uint;
	private var _suit:uint;

	public function PacketThrowCard(id:uint, ordinal:uint, suit:uint) {
		super("ResultTakeCards");

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
