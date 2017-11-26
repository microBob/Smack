//
//  SocketService.swift
//  Smack
//
//  Created by Kenneth on 11/26/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
	
	static let instance = SocketService()
	
	override init() {
		super.init()
	}
	
	var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
	
	func addChannel(name: String, description: String, completion: @escaping CompletionHandler) {
		socket.emit(SOCKET_NEW_CHANNEL, name, description)
		completion(true)
	}
	func getChannel(completion: @escaping CompletionHandler) {
		socket.on(SOCKET_CHANNEL_CREATED) { (dataArray, ack) in
			guard let chName = dataArray[0] as? String else {return}
			guard let chDesc = dataArray[1] as? String else {return}
			guard let chId = dataArray[2] as? String else { return }
			
			let newCh = Channel(channelTitle: chName, channelDescription: chDesc, id: chId)
			MessageService.instance.channels.append(newCh)
			
			completion(true)
		}
	}
	func addMessage(messageBod: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
		let user = UserDataService.instance
		socket.emit(SOCKET_NEW_MESSAGE, messageBod, userId, channelId, user.name, user.avatarName, user.avatarColor)
		completion(true)
	}
	
	
	func estabConnect() {
		socket.connect()
	}
	func cutConnect() {
		socket.disconnect()
	}
}