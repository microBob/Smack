//
//  MessageService.swift
//  Smack
//
//  Created by Kenneth on 11/25/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
	static let instance = MessageService()
	var channels = [Channel]()
	var messages = [Message]()
	var selectedChannel : Channel?
	
	func findAllChannels(completion: @escaping CompletionHandler) {
		Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (resp) in
			if resp.result.error == nil {
				guard let data = resp.data else {return}
				if let json = JSON(data: data).array {
					for i in json {
						let name = i["name"].stringValue
						let channelDes = i["description"].stringValue
						let id = i["_id"].stringValue
						
						let channel = Channel(channelTitle: name, channelDescription: channelDes, id: id)
						self.channels.append(channel)
					}
					
					NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
					completion(true)
				}
			} else {
				completion(false)
				debugPrint(resp.result.error as Any)
			}
		}
	}
	func clearChannels() {
		channels.removeAll()
	}
	func findAllMessagesForChannel(channelID: String, completion: @escaping CompletionHandler) {
		Alamofire.request("\(URL_GET_MESSAGES)\(channelID)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (resp) in
			if resp.result.error == nil {
				self.clearMessages()
				guard let data = resp.data else {return}
				if let json = JSON(data: data).array {
					for item in json {
						self.messages.append(Message(message: item["messageBody"].stringValue, userName: item["userName"].stringValue, channelId: item["channelId"].stringValue, userAvatar: item["userAvatar"].stringValue, userAvatarColor: item["userAvatarColor"].stringValue, id: item["_id"].stringValue, timeStamp: item["timeStamp"].stringValue))
					}
					completion(true)
				}
			} else {
				debugPrint(resp.result.error as Any)
				completion(false)
			}
		}
	}
	func clearMessages() {
		messages.removeAll()
	}
}
