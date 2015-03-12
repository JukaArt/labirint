/**
 * Created by juka on 08.04.14.
 */
package ru.app.items.puzzles {
import com.greensock.TweenMax;

import flash.display.Sprite;
import flash.events.MouseEvent;

import lib.ElementsUI;

import ru.core.Core;

public class PuzzleItem extends Sprite {

	private var _ui:ElementsUI;
	private var _id:uint;
	private var _puzzleId:uint;
	private var _havePrize:Boolean;
	private var _active:Boolean;
	private var _prizeId:uint;
	private var _vector:Vector4;
	private var _puzzleRotate:Number;
	private var _viewType:uint;
	private var _memberOn:Boolean;
	private var _object:*;
	private var _changeable:Boolean;

	public function PuzzleItem() {

	}

	public function setParams(id:uint):void {
		_id = id;

		_ui = new ElementsUI();
		addChild(_ui);

		_viewType = Core.instance.dataManager.game.allPuzzles.items[id].viewType;
		_ui.gotoAndStop(_viewType);
		_puzzleRotate = Core.instance.dataManager.game.allPuzzles.items[id].rotateValue;
		_ui.rotation = _puzzleRotate;

		_puzzleId = Core.instance.dataManager.game.allPuzzles.items[id].puzzleId;


		var vectorArray:Array = Core.instance.dataManager.game.allPuzzles.items[id].rotationPos;
		_vector = new Vector4(vectorArray[0], vectorArray[1], vectorArray[2], vectorArray[3]);


		Core.instance.eventManager.regEvent(_ui, MouseEvent.CLICK, uiClickHandler);

	}

	private function clickHandler(e:MouseEvent):void {
	}

	public function setActiveStatus(value:Boolean):void {
		_active = value;
	}

	public function setMemeberOn(value:Boolean):void {
		_memberOn = value;
	}

	public function setId(id:uint):void {
		_id = id;
	}

	public function chooseView(num:Number):void {
		if(!_ui) {
			_ui = new ElementsUI();
			addChild(_ui);
		}

		_ui.gotoAndStop(num);

		if(num == 1) {
			_vector = new Vector4(1, 0, 1, 0);
		} else if (num == 2){
			_vector = new Vector4(1, 1, 1, 0);
		} else {
			_vector = new Vector4(0, 1, 1, 0);
		}

		Core.instance.eventManager.regEvent(_ui, MouseEvent.CLICK, clickHandler);
	}

	public function addRotate(value:Number):void {
		var rot:Number = _ui.rotation + value;
		_puzzleRotate = rot;
		TweenMax.to(_ui,.3, {rotation: rot});
		if(value == 90) {
			_vector.rotate();
		} else{
			for (var i:int = 0; i < 3; i++) {
				_vector.rotate();
			}
		}
	}

	public function rotateElement(value:Number):void {
		_ui.rotation = value;
		if(value != 0) {
			var num:Number = value / 90;
			for (var i:int = 0; i < num; i++) {
				_vector.rotate();
			}
		}

	}

	public function setPrize(obj:*):void {
		_havePrize = true;
		_ui.container.addChild(obj);
		_prizeId = obj.id;
		_object = obj;
	}



	// handlers

	public function uiClickHandler(e:MouseEvent = null):void {
		_ui.chosenBack.alpha = .33;
	}

	public function resetElement():void {
		_ui.chosenBack.alpha = 0;
	}


	//properties

	public function get id():uint {
		return _id;
	}

	public function set id(value:uint):void {
		_id = value;
	}

	public function get vector():Vector4 {
		return _vector;
	}

	public function set vector(value:Vector4):void {
		_vector = value;
	}

	public function get memberOn():Boolean {
		return _memberOn;
	}

	public function set memberOn(value:Boolean):void {
		_memberOn = value;
	}

	public function get havePrize():Boolean {
		return _havePrize;
	}

	public function set havePrize(value:Boolean):void {
		_havePrize = value;
	}

	public function get puzzleId():uint {
		return _puzzleId;
	}

	public function set puzzleId(value:uint):void {
		_puzzleId = value;
	}

	public function get puzzleRotate():Number {
		return _puzzleRotate;
	}

	public function set puzzleRotate(value:Number):void {
		_puzzleRotate = value;
	}

	public function get changeable():Boolean {
		return _changeable;
	}

	public function set changeable(value:Boolean):void {
		_changeable = value;
	}

	public function get prizeId():uint {
		return _prizeId;
	}

	public function set prizeId(value:uint):void {
		_prizeId = value;
	}
}
}
