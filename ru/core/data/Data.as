/**
 * User: ilija
 * Date: 28.11.12
 * Time: 15:37
 */
package ru.core.data {
public class Data {
	private var _type:String;
	private var _id:uint;

	public function Data() {

	}

	public function get type():String { return _type; }

	public function set type(value:String):void { _type = value; }

	public function get id():uint { return _id; }

	public function set id(value:uint):void { _id = value; }
}
}
