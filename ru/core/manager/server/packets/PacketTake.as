/**
 * User: ilija
 * Date: 12.01.13
 * Time: 18:10
 */
package ru.core.manager.server.packets {


public class PacketTake extends Packet {

	private var _id:uint;

	public function PacketTake(id:uint) {
		super("TakeCards");
		_id = id;
	}

	override public function getData():String {
		var data:Object = {};
		data.type = _type;
		data.id = _id;

		return JSON.stringify(data);
	}
}
}
