/**
 * Created by juka on 09.04.14.
 */
package ru.app.data.prizeData {
public class PrizeData {

	private var _havePrize:Boolean;
	private var _prizeId:uint;

	public function PrizeData() {

	}

	public function setData(data:Object):void {
		_havePrize = data.havePrize;
		_prizeId = data.prizeId;
	}

	public function get havePrize():Boolean {
		return _havePrize;
	}

	public function set havePrize(value:Boolean):void {
		_havePrize = value;
	}

	public function get prizeId():uint {
		return _prizeId;
	}

	public function set prizeId(value:uint):void {
		_prizeId = value;
	}
}
}
