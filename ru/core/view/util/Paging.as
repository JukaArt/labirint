/**
 * By: boluchevsky
 * Date: 24.08.12
 * Time: 16:16
 */
package ru.core.view.util {
import com.greensock.TweenMax;

import ru.core.Core;
import ru.core.manager.Settings;

import ru.core.view.button.AnimatedButton;

import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextFormat;

public class Paging extends Sprite {
    private var _totalPages:uint;
    private var _pages:Vector.<AnimatedButton>;

    private var _currentBtn:AnimatedButton;
    private var _currentID:uint = 0;

    private var _start:uint = 0;
    private var _dest:uint;
    private var _show:uint = 8;

    private var _leftArrow:AnimatedButton;
    private var _rightArrow:AnimatedButton;

    private var _lastBtn:AnimatedButton;
    private var _firstBtn:AnimatedButton;

	private var _placeWidth:uint;
	private var _pagesToShow:uint;
	private var _buttonsClass:Class;


    public function Paging(pages:uint, placeWidth:uint = 594, toShow:uint = 8) {
        _totalPages = pages;
		_placeWidth = placeWidth;
		_pagesToShow = toShow;

        if (_totalPages > _pagesToShow) {
            _dest = _pagesToShow;
            _show = _pagesToShow;

//            _leftArrow = new AnimatedButton(new SimpleTextButtonWhiteUI(), "Предыдущая", 0, leftClicked);
//            _leftArrow.enable();
//            _rightArrow = new AnimatedButton(new SimpleTextButtonWhiteUI(), "Следующая", 0, rightClicked);
//            _rightArrow.enable();
        }
        else {
            _dest = _totalPages;
            _show = _totalPages;
        }

		_buttonsClass = Core.instance.factory.getClass(Settings.PAGING_BUTTON);

        updatePagesCount(_totalPages);

    }

    public function updatePagesCount(pages:uint):void {
        _totalPages = pages;

        if (_pages) {
            for each (var item:AnimatedButton in _pages) {
                if (item.stage)
                    removeChild(item);
            }

            if(_lastBtn && _lastBtn.stage)
                removeChild(_lastBtn);

            if(_firstBtn && _firstBtn.stage)
                removeChild(_firstBtn);
        }

        createPageButtons();
    }

    public function setPageId(value:uint):void {
        pageHandler(_pages[value]);
    }

    public function toFirstPage():void {
       _currentID = 0;
       _start = 0;
       _dest = _pagesToShow;

        updatePagesCount(_totalPages);
    }

	public function get currentBtn():AnimatedButton {
		return _currentBtn;
	}


	// private
    private function toFirst(item:AnimatedButton = null):void {
        _start = 0;
        _dest = _pagesToShow;

        updatePagesCount(_totalPages);
        pageHandler(_pages[0]);
    }

    private function toLast(item:AnimatedButton = null):void {
        _start = _totalPages - _pagesToShow;
        _dest = _totalPages;

        updatePagesCount(_totalPages);
        pageHandler(_pages[_pages.length - 1]);
    }


    private function createPageButtons():void {
        _pages = new Vector.<AnimatedButton>;
		var format:TextFormat = new TextFormat();
		format.underline = true;

        for (var i:int = 0; i < _show; i++) {
            _pages.push(new AnimatedButton(new _buttonsClass as MovieClip, (i + _start + 1).toString(), i + _start, pageHandler, true));

			if(_currentID == _pages[i].id) {
				_pages[i].ui.bg.alpha = 1;

				TweenMax.to(_pages[i].ui.label, 0, {colorTransform:{tint:0xffffff, tintAmount:1}});
			}
			else {
				_pages[i].ui.label.setTextFormat(format);
			}
        }

//        if(_totalPages > _show)
//            _pages.push(new AnimatedPageButton(new PageButtonUI(), _totalPages.toString(), _totalPages - 1, (i + 1), pageHandler));

        placeButtons();
    }

    private function placeButtons():void {
        var _lastPoint:uint;

        _lastPoint = (_placeWidth - (_pages[i].width + 5) * _show) / 2;

        for (var i:int = 0; i < _pages.length; i++) {
            _pages[i].enable();
            _pages[i].x = _lastPoint;
            addChild(_pages[i]);

            _lastPoint = _pages[i].x + _pages[i].width + 5;

            if (_pages[i].id == _currentID) {
                _pages[i].disable();
                _currentBtn = _pages[i];
            }

        }

        if(_lastBtn)
            _lastBtn.x = _lastPoint;

        if (_totalPages > _pagesToShow)
            updateArrow();
    }

    private function updateArrow():void {
        if(_pages[_pages.length - 1].id != _totalPages - 1) {
            _lastBtn = new AnimatedButton(new _buttonsClass as MovieClip, ".. " + _totalPages.toString(), _totalPages - 1, toLast, true);
            _lastBtn.enable();
            _lastBtn.x = _pages[_pages.length - 1].x + _pages[_pages.length - 1].width;
            addChild(_lastBtn);
        }

        if(_pages[0].id != 0) {
            _firstBtn = new AnimatedButton(new _buttonsClass as MovieClip, "1 ..", 0, toFirst);
            _firstBtn.enable();
            _firstBtn.x = _pages[0].x - 25;
            addChild(_firstBtn);
        }

//        _leftArrow.x = _pages[0].x - _leftArrow.width - 10;
//        _rightArrow.x = _pages[_pages.length - 1].x + _pages[_pages.length - 1].width + 54;
//
//        _leftArrow.enable();
//        _leftArrow.alpha = 1;
//        _rightArrow.enable();
//        _rightArrow.alpha = 1;
//        addChild(_leftArrow);
//        addChild(_rightArrow);
//
//        if (_currentID == 0) {
//            _leftArrow.alpha = .3;
//            _leftArrow.disable();
//        }
//        else if (_currentID == _totalPages - 1) {
//            _rightArrow.alpha = .3;
//            _rightArrow.disable();
//        }
    }


    //HANDLER
    private function pageHandler(button:AnimatedButton):void {
        if (_currentBtn) {
            _currentBtn.enable();
            _currentBtn.ui.bg.alpha = 0;
        }

        button.disable();
        button.ui.bg.alpha = 1;
        _currentBtn = button;
        _currentID = button.id;

        if (_currentBtn.id + 1 == _dest && _dest < _totalPages) {
            ++_dest;
            ++_start;
        }
        else if (_currentBtn.id == _start && _start != 0) {
            --_dest;
            --_start;
        }

        dataComplete();
    }

    private function dataComplete():void {
        dispatchEvent(new Event(Event.CHANGE));
    }

    private function rightClicked():void {
        pageHandler(_pages[_currentBtn.id + 1]);
    }

    private function leftClicked():void {
        pageHandler(_pages[_currentBtn.id - 1]);
    }

}
}
