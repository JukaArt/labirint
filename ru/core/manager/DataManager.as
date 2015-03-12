/**
 * By: boluchevsky
 * Date: 24.08.12
 * Time: 10:38
 */
package ru.core.manager {
import ru.core.data.Data;
import ru.app.data.GameData;
import ru.core.data.UserData;

public class DataManager {
	private var _pool:Object;
	private var _user:UserData;
	private var _game:GameData;

	public function DataManager() {
		_pool = {};
	}


	// SET CONSTANT DATA
	public function setData(data:Data):void {
		if (!_pool.hasOwnProperty(data.type))
			_pool[data.type] = data;
	}

	public function getData(type:String):Data {
		if (_pool.hasOwnProperty(type))
			return _pool[type];
		else
			return null;
	}

	// properties
	public function get user():UserData {
		if(!_user)
			_user = new UserData();

		return _user;
	}

	public function get game():GameData {
		if(!_game)
			_game = new GameData();

		return _game;
	}
}
}
