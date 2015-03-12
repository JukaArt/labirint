/**
 * Created by juka on 10.04.14.
 */
package ru.app.data.pathData {
public class StepData {

	private var _changeable:Boolean;
	private var _puzzleId:uint;

	public function StepData(data:Object) {
		_changeable = data.changeable;
		_puzzleId = data.puzzleId;
	}

	public function get changeable():Boolean {
		return _changeable;
	}

	public function set changeable(value:Boolean):void {
		_changeable = value;
	}

	public function get puzzleId():uint {
		return _puzzleId;
	}

	public function set puzzleId(value:uint):void {
		_puzzleId = value;
	}
}
}
