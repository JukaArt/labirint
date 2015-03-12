package ru.core.view.util {

import com.greensock.TweenMax;
import com.greensock.easing.Expo;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

public class Slider extends EventDispatcher {
    public static const VALUE_CHANGED:String = "valueChanged";

    private var _ui:MovieClip;
    private var _isDrag:Boolean = false;
    private var _isMouseDown:Boolean = false;
    private var _value:Number = 0;

    public function Slider(ui:MovieClip) {
        _ui = ui;
        setupUI();
    }

    // public properties:
    public function get isDrag():Boolean {
        return _isDrag;
    }

    public function get lineHeight():Number {
        return ui.line.height - handleHeight;
    }

    public function set lineHeight(height:Number):void {
        ui.line.height = height + handleHeight;
    }

    public function get value():Number {
        return _value;
    }

    public function set value(value:Number):void {
        if (value != _value) {
            _value = value;
            updateValue();
        }
    }

    protected function get handleHeight():Number {
        return ui.handle.height;
    }

    protected function get ui():MovieClip {
        return _ui;
    }

    // protected:
    protected function setupUI():void {
        ui.mouseChildren = false;
        ui.buttonMode = true;

        ui.addEventListener(MouseEvent.MOUSE_DOWN, sliderDownHandler, false, 0, true);
        ui.addEventListener(MouseEvent.MOUSE_UP, sliderUpHandler, false, 0, true);
        ui.addEventListener(MouseEvent.MOUSE_MOVE, sliderMoveHandler, false, 0, true);
    }

    // private:
    private function updateValue():void {
        if (!isDrag)
            ui.handle.y = value * lineHeight;
        dispatchEvent(new Event(VALUE_CHANGED));
    }

    // handlers:
    private function sliderDownHandler(event:MouseEvent):void {
        _isMouseDown = true;
    }

    private function sliderUpHandler(event:MouseEvent):void {
        if (_isMouseDown && !_isDrag) {
            var val:Number = Math.max(0, Math.min(1, (event.localY - (handleHeight / 2)) / lineHeight));
            TweenMax.to(this, 1, { value: val, ease:Expo.easeOut } );
            _isMouseDown = false;
        }
    }

    private function sliderMoveHandler(event:MouseEvent):void {
        if (_isMouseDown && !_isDrag) {
            ui.handle.y = event.localY - (handleHeight / 2);
            ui.handle.startDrag(false, new Rectangle(0, 0, 0, lineHeight));

            ui.stage.addEventListener(MouseEvent.MOUSE_UP, handleUpHandler, false, 0, true);
            ui.stage.addEventListener(MouseEvent.MOUSE_MOVE, stageMoveHandler, false, 0, true);

            _isDrag = true;
        }
    }

    private function handleUpHandler(event:MouseEvent):void {
        ui.stage.removeEventListener(MouseEvent.MOUSE_UP, handleUpHandler);
        ui.stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMoveHandler);
        ui.handle.stopDrag();
        _isMouseDown = false;
        _isDrag = false;
        updateValue();
    }

    private function stageMoveHandler(event:MouseEvent):void {
        value = Math.max(0, Math.min(1, ui.handle.y / lineHeight));
    }
}
}
