/**
 * User: ilija
 * Date: 27.12.12
 * Time: 21:26
 */
package ru.core.manager.server.packets {

public class PacketPass extends Packet {
	private var _id:uint;

	public function PacketPass(id:uint, type:String = "Pass") {
		super(type);
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
