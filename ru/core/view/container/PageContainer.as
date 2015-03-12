/**
 * By: boluchevsky
 * Date: 16.09.12
 * Time: 15:10
 */
package ru.core.view.container {
import ru.core.view.primary.Container;
import ru.core.view.primary.Page;
import ru.core.view.primary.View;

public class PageContainer extends Container{
    private var _currentPage:Page;
    private var _prevPage:Page;

    private var _history:Vector.<Page>;

    public function PageContainer() {
        _history = new Vector.<Page>;
    }

    public function addPage(page:Page):void {
        if(_currentPage)
            _currentPage.hide();

        page.container = this;
        addChild(page);
        page.init();

        _currentPage = page;
    }

    public function removePrevPage():void {
        if(_currentPage) {
            _currentPage.hide();
//            _prevPage = _currentPage;
        }
    }

    override public function remove(page:View):void {
            removeChild(page);
    }

}
}
