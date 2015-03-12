/**
 * User: ilija
 * Date: 19.10.12
 * Time: 13:02
 */
package ru.core.manager.server.requests {

import ru.core.Core;
import ru.core.manager.Settings;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

public class CustomRequest extends EventDispatcher{
	private var _reguest:URLRequest;
	private var _vars:URLVariables;
	private var _loader:URLLoader;

	private var _baseUrl:String;
	private var _url:String;
	private var _data:Object;
	private var _complete:Function;
	private var _method:String;

	public function CustomRequest(url:String, data:Object, complete:Function = null, method:String = URLRequestMethod.POST) {
		_baseUrl = Core.instance.settings.baseUrl;
		_url = url;
		_data = data;
		_complete = complete;
		_method = method;
	}

	public function load():void {
		_reguest = new URLRequest(_baseUrl + _url);
		_reguest.method = _method;
		_reguest.contentType = "application/json";

		_vars = new URLVariables();

//		_reguest.data = JSON.encode(_data);
		_reguest.data = JSON.stringify(_data);

		_loader = new URLLoader();
		_loader.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
		_loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler, false, 0, true);
		_loader.load(_reguest);
	}

	protected function completeHandler(event:Event):void {
		Settings.traceString(_url + " REQUEST ANSWER!: " + _loader.data);

		_loader.removeEventListener(Event.COMPLETE, completeHandler);
		_loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);

//		var data:Object = JSON.decode(_loader.data as String);
		var data:Object = JSON.parse(_loader.data as String);

		if(_complete != null)
			_complete(data);

		dispatchEvent(new Event(Event.COMPLETE));
	}

	protected function errorHandler(event:IOErrorEvent):void {
		Settings.traceString(event.toString());
	}
}
}
