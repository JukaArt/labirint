/**
 * Created by juka on 04.03.14.
 */
package ru.app.items.puzzles {
public class Vector4 {


	private var _x:Number;
	private var _y:Number;
	private var _z:Number;
	private var _v:Number;

	private var _vector:Array;

	public function Vector4(x:Number, y:Number, z:Number, v:Number) {
		setVector4(x, y, z, v);
	}

	public function setVector4(x:Number, y:Number, z:Number, v:Number):void {
		_x = x;
		_z = z;
		_y = y;
		_v = v;
		_vector = [x, y, z, v];
	}

	public function rotate():void {
		_vector.splice(0, 0, _vector[_vector.length - 1]);
		_vector.splice(_vector.length - 1, 1);
	}

	// properties

	public function get x():Number {	return _x;	}

	public function set x(value:Number):void {	_x = value;	}

	public function get y():Number {	return _y;	}

	public function set y(value:Number):void {	_y = value;	}

	public function get z():Number {	return _z;	}

	public function set z(value:Number):void {	_z = value;	}

	public function get v():Number {	return _v;	}

	public function set v(value:Number):void {	_v = value;	}

	public function get vector():Array {
		return _vector;
	}

	public function set vector(value:Array):void {
		_vector = value;
	}
}
}
