/**
 * By: boluchevsky
 * Date: 28.06.12
 * Time: 9:49
 */
package ru.core {
import flash.display.Stage;

import ru.core.manager.DataManager;
import ru.core.manager.EventManager;
import ru.core.manager.Factory;
import ru.core.manager.RenderManager;
import ru.core.manager.ServerManager;
import ru.core.manager.SocialManager;
import ru.core.view.ViewCore;

import ru.core.manager.AnimationManager;
import ru.core.manager.Settings;


public class Core {
    private var _uiManager:ViewCore;
    private var _dataManager:DataManager;
    private var _serverManager:ServerManager;
    private var _socialManager:SocialManager;
	private var _renderManager:RenderManager;
    private var _animationManager:AnimationManager;
	private var _eventManager:EventManager;
    private var _factory:Factory;
    private var _settings:Settings;
    private var _stage:Stage;
	private var _host:String;

    private static var _instance:Core;

    public function Core(item:PrivateClass) {

    }

    public static function get instance():Core {
        if (!Core._instance)
            Core._instance = new Core(new PrivateClass);

        return Core._instance;
    }


    // INIT ;)
    public function init(stage:Stage, settings:Settings, complete:Function = null):void {
        _stage = stage;
		_settings = settings;

		if(_stage.loaderInfo.parameters.logged_user_id) {  // OK
			dataManager.user.socData = _stage.loaderInfo.parameters;
		}
		else if(_stage.loaderInfo.parameters.viewer_id) {  // VK
			dataManager.user.socData = _stage.loaderInfo.parameters;
		}
		else if(_stage.loaderInfo.parameters.user_id) {    // FB
			dataManager.user.socData = _stage.loaderInfo.parameters;
		}
		else { 											   // OFFLINE
			settings.isOnline = false;
			dataManager.user.socData = settings.socData;
		}

		settings.appWidth = _stage.stageWidth;
		settings.appHeight = _stage.stageHeight;

		settings.init(complete);
    }


    // VIEW MANAGER
    public function get uiManager():ViewCore {
        if (!_uiManager)
            _uiManager = new ViewCore();

        return _uiManager;
    }

	// DATA MANAGER
    public function get dataManager():DataManager {
        if (!_dataManager)
            _dataManager = new DataManager();

        return _dataManager;
    }

	// SERVER MANAGER
    public function get serverManager():ServerManager {
        if (!_serverManager)
            _serverManager = new ServerManager();

        return _serverManager;
    }

	// SOCIAL MANAGER
    public function get socialManager():SocialManager {
        if(!_socialManager)
            _socialManager = new SocialManager();

        return _socialManager;
    }

	// ANIMATION MANAGER
    public function get animationManager():AnimationManager {
        if (!_animationManager)
            _animationManager = new AnimationManager();

        return _animationManager;
    }

	// RENDER MANAGER
	public function get render():RenderManager {
		if(!_renderManager)
			_renderManager = new RenderManager();

		return _renderManager;
	}

	// EVENT MANAGER
	public function get eventManager():EventManager {
		if(!_eventManager)
			_eventManager = new EventManager();

		return _eventManager;
	}

	// FACTORY
	public function get factory():Factory {
		if(!_factory)
			_factory = new Factory();

		return _factory;
	}

    //SETTINGS
    public function get settings():Settings {
        return _settings;
    }


    // STAGE
    public function get stage():Stage {
        return _stage;
    }

	public function get host():String {
		return _host;
	}

	public function set host(value:String):void {
		_host = value;
	}
}
}

class PrivateClass {
    public function PrivateClass() {

    }
}
