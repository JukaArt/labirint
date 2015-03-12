/**
 * User: ilija
 * Date: 15.10.12
 * Time: 13:51
 */
package ru.core.view.container {
import ru.core.view.primary.Container;
import ru.core.view.primary.Menu;

public class MenuContainer extends Container {
	private var _pool:Vector.<Menu>;

    public function MenuContainer() {
		_pool = new Vector.<Menu>;
    }

	public function setMenu(newMenu:Menu):void {
		_pool.push(newMenu);
	}

    public function updateMenu(name:String):void {
		for each (var item:Menu in _pool) {
			item.update(name);
		}
    }
}
}
