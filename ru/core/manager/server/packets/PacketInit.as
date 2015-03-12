/**
 * User: ilija
 * Date: 24.12.12
 * Time: 10:31
 */
package ru.core.manager.server.packets {

import ru.core.Core;

public class PacketInit extends Packet {

	public function PacketInit() {
		super("Init");
	}

	override public function getData():String {
		var data:Object = {};
		data.type = _type;

		data.user = {};
		data.user.first_name = Core.instance.dataManager.user.firstName;
		data.user.last_name = Core.instance.dataManager.user.lastName;
		data.user.email = Core.instance.dataManager.user.email;
		data.user.avatar_url = Core.instance.dataManager.user.avatarUrl;

		return JSON.stringify(data);
	}

}
}
