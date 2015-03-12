/**
 * By: boluchevsky
 * Date: 24.09.12
 * Time: 12:39
 */
package ru.core.manager {
public class SocialManager {

	public static const VK_ENGINE:String = "vkEngine";
	public static const OK_ENGINE:String = "okEngine";
	public static const FB_ENGINE:String = "fbEngine";

    public function SocialManager() {

    }

	public function init(type:String):void {
		switch (type) {
			case VK_ENGINE :
				break;
			case OK_ENGINE :
				break;
			case FB_ENGINE :
				break;
		}
	}
}
}
