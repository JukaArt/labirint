/**
 * By: boluchevsky
 * Date: 06.09.12
 * Time: 13:15
 */
package ru.core.view {
import flash.events.ContextMenuEvent;
import flash.ui.ContextMenu;
import flash.ui.ContextMenuItem;

import lib.BackUI;

import ru.app.items.MessageLine;

import ru.core.Core;
import ru.core.view.container.DebugContainer;
import ru.core.view.container.MenuContainer;
import ru.core.view.container.PageContainer;
import ru.core.view.container.PopupContainer;
import ru.core.view.container.PreloaderContainer;
import ru.core.view.primary.Menu;
import ru.core.view.primary.Page;
import ru.core.view.primary.Popup;
import ru.core.view.container.RenderContainer;

import flash.display.Sprite;

public class ViewCore extends Sprite {
    private var _pageContainer:PageContainer;
    private var _popUpContainer:PopupContainer;
    private var _menuContainer:MenuContainer;
	private var _preloaderContainer:PreloaderContainer;
	private var _renderContainer:RenderContainer;
	private var _debugContainer:DebugContainer;


	private var _back:BackUI;
	private var _msgLine:MessageLine;

    public function ViewCore() {
        Core.instance.stage.addChild(this);
        setup();
    }


    // PAGE
    public function showPage(name:String, data:Object = null):void {
        var pageClass:Class = Core.instance.factory.getClass(name);
        var page:Page = new pageClass as Page;

        page.viewLabel = name;
        page.addData(data);

        _pageContainer.addPage(page);
        _menuContainer.updateMenu(name);
    }

	public function showPreviousPage():void {

	}

    public function hidePage():void {
        _pageContainer.removePrevPage();
    }


    // POPUP
    public function showPopup(name:String, data:Object = null):void {
        var popupClass:Class = Core.instance.factory.getClass(name);
        var popup:Popup = new popupClass as Popup;

        popup.viewLabel = name;
        popup.addData(data);

        _popUpContainer.addPopup(popup);
    }

    public function hidePopup():void {
        _popUpContainer.removePopup();
    }


	// MENU
	public function addMenu(menu:Menu):void {

	}

	public function hideMenu():void {

	}


    // LOADER
    public function showLoader():void {
		_preloaderContainer.show();
    }

    public function hideLoader():void {
		_preloaderContainer.hide();
    }


	//DEBUG
	public function enableDebug():void {
		_debugContainer.enable();
	}

	public function disableDebug():void {
		_debugContainer.disable();
	}


    // SETUP
    private function setup():void {

		if(Core.instance.settings.render) {
			_renderContainer = new RenderContainer();
			addChild(_renderContainer);
			Core.instance.render.setContainer(_renderContainer);
		}

		_back = new BackUI();
		addChild(_back);

		_msgLine = new MessageLine();
		addChild(_msgLine);

		_pageContainer = new PageContainer();
        addChild(_pageContainer);


		_popUpContainer = new PopupContainer();
        addChild(_popUpContainer);


		_menuContainer = new MenuContainer();
        addChild(_menuContainer);


		_preloaderContainer = new PreloaderContainer();
		addChild(_preloaderContainer);


		if(Core.instance.settings.debug) {
			_debugContainer = new DebugContainer();
			addChild(_debugContainer);
			enableDebug();
		}


		// copyright
		var myMenu:ContextMenu = new ContextMenu();
		myMenu.hideBuiltInItems();

		var cutItem:ContextMenuItem = new ContextMenuItem("Juka Art");
		cutItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
		myMenu.customItems.push(cutItem);


		this.contextMenu = myMenu;

    }

	// handlers
	private function menuItemSelectHandler(event:ContextMenuEvent):void {

	}


	// properties
	public function get pageContainer():PageContainer {
		return _pageContainer;
	}

	public function get popUpContainer():PopupContainer {
		return _popUpContainer;
	}

	public function get menuContainer():MenuContainer {
		return _menuContainer;
	}

	public function get preloaderContainer():PreloaderContainer {
		return _preloaderContainer;
	}

	public function get renderContainer():RenderContainer {
		return _renderContainer;
	}

	public function get msgLine():MessageLine {
		return _msgLine;
	}

	public function set msgLine(value:MessageLine):void {
		_msgLine = value;
	}
}
}
