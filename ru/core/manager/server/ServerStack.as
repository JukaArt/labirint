/**
 * User: ilija
 * Date: 28.10.12
 * Time: 18:51
 */
package ru.core.manager.server {
import ru.core.manager.server.requests.CustomRequest;

public class ServerStack {
	private var _stack:Vector.<CustomRequest>;

	public function ServerStack() {
		_stack = new Vector.<CustomRequest>;
	}

	public function setRequest(request:CustomRequest):void {

	}
}
}
