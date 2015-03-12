/**
 * By: boluchevsky
 * Date: 16.09.12
 * Time: 21:50
 */
package ru.core.view.primary {
import flash.display.Sprite;

public class Container extends Sprite {

    public function Container() {

    }

    public function remove(item:View):void {
        removeChild(item);
    }


}
}
