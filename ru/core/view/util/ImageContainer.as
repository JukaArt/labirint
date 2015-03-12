package ru.core.view.util {
import ru.core.Core;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.geom.Matrix;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.SecurityDomain;

public class ImageContainer extends Sprite {
	private var _url:String;
	private var _loader:Loader;

	private var _w:uint;
	private var _h:uint;
	private var _mask:Sprite;
	private var _data:*;

	private var _fullResize:Boolean;
	private var _ui:MovieClip;

	public function ImageContainer(url:String, w:uint = 50, h:uint = 50, fullResize:Boolean = true, autoLoad:Boolean = true) {
		_url = url;
		_fullResize = fullResize;

		_w = w;
		_h = h;

		if (autoLoad)
			loadImg();
	}


	// properties
	public function load():void { loadImg(); }

	public function setData(item:*):void { _data = item; }

	override public function get width():Number { return _w; }

	public function set loaderUI(item:MovieClip):void { _ui = item; }

	public function get data():* { return _data; }

	public function get image():Bitmap { return _loader.content as Bitmap; }


	// private
	private function loadImg():void {

		if (_ui) {
			_ui.x = _w / 2;
			_ui.y = _h / 2;
			addChild(_ui);
		}

		_loader = new Loader();

		if (Core.instance.settings.isOnline)
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);


		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompleteHandler, false, 0, true);
		_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler, false, 0, true);
		_loader.load(new URLRequest(_url), context);
	}

	private function loadCompleteHandler(event:Event):void {
		_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadCompleteHandler);

		var clone:Bitmap = _loader.content as Bitmap;

		var img:Bitmap = new Bitmap(clone.bitmapData.clone());
		img.smoothing = true;

		dispatchEvent(new Event(Event.COMPLETE));

		var matrix:Matrix = new Matrix();
		var percent:Number;

		if (img.width > _w || img.width < _w) {
			percent = _w / img.width;
			matrix.scale(percent, percent);
			img.transform.matrix = matrix;
		}

		if (img.height < _h && _fullResize == true) {
			percent = _h / img.height;
			matrix.scale(percent, percent);
			img.transform.matrix = matrix;
		}

		if (_ui)
			removeChild(_ui);

		addChild(img);

		_mask = new Sprite();
		_mask.graphics.beginFill(0xFF0000);
		_mask.graphics.drawRect(0, 0, _w, _h);
		_mask.graphics.endFill();
		_mask.width = _w;
		_mask.height = _h;
		addChild(_mask);

		img.cacheAsBitmap = true;
		_mask.cacheAsBitmap = true;

		img.mask = _mask;

		dispatchEvent(new Event(Event.COMPLETE));
	}

	// handlers
	private function errorHandler(event:IOErrorEvent):void {
		trace(event.toString());
	}

}

}
