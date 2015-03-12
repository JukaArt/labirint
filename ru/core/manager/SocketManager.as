/**
 * User: ilija
 * Date: 21.12.12
 * Time: 17:07
 */
package ru.core.manager {
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.Socket;
import flash.utils.ByteArray;

import ru.core.Core;

import ru.core.manager.server.PacketManager;
import ru.core.manager.server.packets.Packet;

public class SocketManager {
	private var _socket:Socket;
	private var _complete:Function;

	private var _packetManager:PacketManager;

	private var _messages:Vector.<String>;

	public function SocketManager() {
		_packetManager = new PacketManager();
		_messages = new Vector.<String>;
	}

	public function init(complete:Function = null):void {
		_socket = new Socket();
		_complete = complete;

		_socket.addEventListener(Event.CLOSE, closeHandler);
		_socket.addEventListener(Event.CONNECT, connectHandler);
		_socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		_socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);

		_socket.connect("192.168.122.102", 63500);
//		_socket.connect(Core.instance.settings.host, 63500);
	}

	public function close():void {
		if(_socket)
			_socket.close();

		_socket = null;
	}

	public function sendPacket(packet:Packet):void {
		sendMessage(packet.getData());
	}

	// private
	private function sendMessage(message:String):void {
		_socket.writeUTFBytes(message);
		_socket.flush();
	}

	// handler
	private function socketDataHandler(event:ProgressEvent):void {
		var bytes:ByteArray = new ByteArray();
		var message:ByteArray = new ByteArray();

		_socket.readBytes(bytes, 0, _socket.bytesAvailable);

		for (var i:int = 0; i < bytes.length; i++) {
			message[i] = bytes[i];

			if(bytes[i] == 0) {
				_packetManager.translate(message.readUTFBytes(message.bytesAvailable));
			}
		}

		message.clear();
	}

	private function securityErrorHandler(event:SecurityErrorEvent):void {
		trace("SECURITY ERROR");
	}

	private function ioErrorHandler(event:IOErrorEvent):void {
		trace("IO ERROR", event);
	}

	private function connectHandler(event:Event):void {
		trace("CONNECTED");

		if (_complete != null)
			_complete();
	}

	private function closeHandler(event:Event):void {
		trace("SERVER CLOSE");
	}

	public function get packetManager():PacketManager {
		return _packetManager;
	}
}
}
