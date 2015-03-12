/**
 * By: boluchevsky
 * Date: 24.08.12
 * Time: 10:38
 */
package ru.core.manager {
import ru.core.Core;
import ru.core.manager.server.ServerStack;

public class ServerManager {
	private var _stack:ServerStack;
    private var _baseUrl:String;

    public function ServerManager() {
		_stack = new ServerStack();
        _baseUrl = Core.instance.settings.baseUrl;
    }

	public function init():void {

	}



}
}
