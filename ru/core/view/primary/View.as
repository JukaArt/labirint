/**
 * By: boluchevsky
 * Date: 16.09.12
 * Time: 15:13
 */
package ru.core.view.primary {
import flash.display.MovieClip;
import flash.display.Sprite;

public class View extends Sprite{
    private var _id:uint;
    private var _viewLabel:String;
    private var _ui:MovieClip;
    private var _data:Object;
    private var _container:Container;

    public function View() {

    }


    // PUBLIC
    public function init():void {

    }

    public function hide():void {

    }

    public function destroy():void {
        _container.remove(this);
    }

    public function addData(data:Object):void {
        _data = data;
    }

    public function get data():Object {
        return _data;
    }


    // PROPERTIES
	public function get id():uint {
		return _id;
	}

	public function set id(value:uint):void {
		_id = value;
	}

	public function get viewLabel():String {
		return _viewLabel;
	}

	public function set viewLabel(value:String):void {
		_viewLabel = value;
	}

	public function get ui():MovieClip {
		return _ui;
	}

	public function set ui(value:MovieClip):void {
		_ui = value;
	}

	public function get container():Container {
		return _container;
	}

	public function set container(value:Container):void {
		_container = value;
	}
}
}
