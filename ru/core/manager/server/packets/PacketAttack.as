/**
 * User: ilija
 * Date: 26.12.12
 * Time: 16:02
 */
package ru.core.manager.server.packets {

public class PacketAttack extends Packet {

	private var _id:uint;
	private var _ordinal:uint;
	private var _suit:uint;

	public function PacketAttack(id:uint, ordinal:uint, suit:uint) {
		super("AttackResult");

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
