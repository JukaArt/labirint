/**
 * User: ilija
 * Date: 24.12.12
 * Time: 10:47
 */
package ru.core.manager.server.packets {
public class Packet {

	protected var _type:String;

	public function Packet(type:String) {
		_type = type;
	}

	public function getData():String {
		return "";
	}
}
}
