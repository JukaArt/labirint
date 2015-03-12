/**
 * By: boluchevsky
 * Date: 24.08.12
 * Time: 10:42
 */
package ru.core.data {

public class UserData extends Data{
	private var _userId:String;
	private var _socId:String;
	private var _firstName:String;
	private var _lastName:String;
	private var _fullName:String;
	private var _gender:String;
	private var _avatarUrl:String;
	private var _newbie:Boolean;
	private var _socData:Object;

	public static const TYPE:String = "UserData";

	public function UserData() {
		super.type = TYPE;
	}

	public function get fullName():String {
		return _fullName;
	}

	public function set fullName(value:String):void {
		_fullName = value;
	}

	public function get userId():String {
		return _userId;
	}

	public function set userId(value:String):void {
		_userId = value;
	}

	public function get avatarUrl():String {
		return _avatarUrl;
	}

	public function set avatarUrl(value:String):void {
		_avatarUrl = value;
	}

	public function get firstName():String {
		return _firstName;
	}

	public function set firstName(value:String):void {
		_firstName = value;
	}

	public function get lastName():String {
		return _lastName;
	}

	public function set lastName(value:String):void {
		_lastName = value;
	}

	public function get newbie():Boolean {
		return _newbie;
	}

	public function set newbie(value:Boolean):void {
		_newbie = value;
	}

	public function get socId():String {
		return _socId;
	}

	public function set socId(value:String):void {
		_socId = value;
	}

	public function get gender():String {
		return _gender;
	}

	public function set gender(value:String):void {
		_gender = value;
	}

	public function get socData():Object {
		return _socData;
	}

	public function set socData(value:Object):void {
		_socData = value;
	}
}
}
