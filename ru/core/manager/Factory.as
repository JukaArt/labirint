/**
 * User: ilija
 * Date: 15.10.12
 * Time: 16:54
 */
package ru.core.manager {

public class Factory {
    private var _data:Vector.<Object>;

    public function Factory() {
        _data = new Vector.<Object>;
    }

    public function setClass(id:String, item:Class):void {
        var data:Object = new Object();
        data.id = id;
        data.item = item;
        _data.push(data);
    }

    public function getClass(id:String):Class {
		for each (var data:Object in _data) {
            if(data.id == id) {
                return data.item;
            }
        }

        return null;
    }
}
}
