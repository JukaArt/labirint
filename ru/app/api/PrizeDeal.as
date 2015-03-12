/**
 * Created by juka on 13.04.14.
 */
package ru.app.api {
public class PrizeDeal {


	private var _prizes:Array;
	private var _firstMemberPrizes:Array;
	private var _secondMemberPrizes:Array;
	private var _thirdMemberPrizes:Array;
	private var _forthMemebrPrizes:Array;

	public function PrizeDeal() {
		_prizes = [];
		_firstMemberPrizes = [];
		_secondMemberPrizes = [];
		_thirdMemberPrizes = [];
		_forthMemebrPrizes = [];


		var tempArray:Array = [];

		for (var k:int = 0; k < 24; k++) {
			tempArray.push(k + 1);
		}

		_prizes = randomizePrize(tempArray);

		for (var i:int = 0; i < _prizes.length; i++) {
			if(i <= 5) {
				_firstMemberPrizes.push(_prizes[i]);
			} else if(i > 5 && i <= 11) {
				_secondMemberPrizes.push(_prizes[i]);
			} else if(i > 11 && i <= 16) {
				_thirdMemberPrizes.push(_prizes[i]);
			} else {
				_forthMemebrPrizes.push(_prizes[i]);
			}
		}

		_prizes = [_firstMemberPrizes, _secondMemberPrizes, _thirdMemberPrizes, _forthMemebrPrizes];
	}

	private function randomizePrize(array:Array):Array {
		var tempArray:Array = [];
		var length:Number = array.length;
		for (var i:int = 0; i < length; i++) {
			var num:uint = Math.random() * (array.length - 1);
			tempArray.push(array[num]);
			array.splice(num, 1);
		}
		return tempArray;
	}

	public function get prizes():Array {
		return _prizes;
	}

	public function set prizes(value:Array):void {
		_prizes = value;
	}
}
}
