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
}
