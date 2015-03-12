/**
 * By: boluchevsky
 * Date: 06.09.12
 * Time: 13:00
 */
package ru.core.manager {
import api.com.adobe.json.JSON;

import flash.ui.ContextMenu;
import flash.ui.ContextMenuItem;

import ru.app.pages.GamePage;

import ru.core.Core;

import lib.ClosePopupBtnUI;
import lib.PagingButtonUI;

import ru.app.pages.SamplePage;
import ru.app.popups.SamplePopup;

public class Settings {
	// private
	private var _appWidth:uint;
	private var _appHeight:uint;
	private var _isOnline:Boolean = true;
	private var _initComplete:Function;

	// protected
	protected var _baseUrl:String;
	protected var _debug:Boolean = false;  			// debugging (memory, trace, etc.)
	protected var _render:Boolean = true;			// render movieClip

	protected var _socData:Object;
	protected var _version:String;

	// pages
	public static const SAMPLE_PAGE:String = "SamplePage";
	public static const GAME_PAGE:String = "GamePage";

	// popups
	public static const SAMPLE_POPUP:String = "SamplePopup";

	// elements
	public static const CLOSE_BUTTON:String = "CloseButton";     // ! IMPORTANT
	public static const PAGING_BUTTON:String = "PagingButton";


	public function Settings() {

	}


	// PUBLIC
	public static function traceString(value:String):void {
		trace(value);
	}

	public static function traceObject(value:Object):void {
//		trace(JSON.encode(value));
	}

	// entry
	public function init(complete:Function = null):void {
		_initComplete = complete;
		doInit();
	}


	// PROTECTED
	protected function doInit():void {
		// заполняем библиотеку классами отображения

		createLib(SAMPLE_PAGE, SamplePage);
		createLib(GAME_PAGE, GamePage);


		createLib(SAMPLE_POPUP, SamplePopup);

		createLib(CLOSE_BUTTON, ClosePopupBtnUI);
		createLib(PAGING_BUTTON, PagingButtonUI);

		doInitComplete();
	}

	protected function doInitComplete():void {
		if (_initComplete != null)
			_initComplete.call();
	}

	protected function createLib(id:String, addClass:Class):void {
		Core.instance.factory.setClass(id, addClass);
	}


	// PROPERTIES
	public function get isOnline():Boolean { return _isOnline; }

	public function set isOnline(value:Boolean):void { _isOnline = value; }

	public function get baseUrl():String { return _baseUrl; }

	public function get appWidth():uint { return _appWidth; }

	public function get appHeight():uint { return _appHeight; }

	public function set appWidth(value:uint):void { _appWidth = value; }

	public function set appHeight(value:uint):void { _appHeight = value; }

	public function get debug():Boolean { return _debug; }

	public function get render():Boolean { return _render; }

	public function get socData():Object { return _socData; }

	public function get version():String { return _version; }
}
}
