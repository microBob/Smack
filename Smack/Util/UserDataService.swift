//
//  UserDataService.swift
//  Smack
//
//  Created by Kenneth on 11/23/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import Foundation

class UserDataService {
	static let instance = UserDataService()
	
	public private(set) var id = ""
	public private(set) var avatarColor = ""
	public private(set) var avatarName = ""
	public private(set) var email = ""
	public private(set) var name = ""
	
	func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
		self.id = id
		self.avatarColor = color
		self.avatarName = avatarName
		self.email = email
		self.name = name
	}
	
	func setAvatarName(avatarName: String) {
		self.avatarName = avatarName
	}
	func returnUIColor(components: String) -> UIColor {
		let scann = Scanner(string: components)
		let skipped = CharacterSet(charactersIn: "[], ")
		let comma = CharacterSet(charactersIn: ",")
		scann.charactersToBeSkipped = skipped
		
		let defaultColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
		
		var r, g, b, a : NSString?
		scann.scanUpToCharacters(from: comma, into: &r)
		scann.scanUpToCharacters(from: comma, into: &g)
		scann.scanUpToCharacters(from: comma, into: &b)
		scann.scanUpToCharacters(from: comma, into: &a)
		
		guard let rUnwrapped = r else { return defaultColor }
		guard let gUnwrapped = g else { return defaultColor }
		guard let bUnwrapped = b else { return defaultColor }
		guard let aUnwrapped = a else { return defaultColor }
		
		let rFloat = CGFloat(rUnwrapped.doubleValue)
		let gFloat = CGFloat(gUnwrapped.doubleValue)
		let bFloat = CGFloat(bUnwrapped.doubleValue)
		let aFloat = CGFloat(aUnwrapped.doubleValue)
		
		return UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
	}
	
	func logoutUser() {
		id = ""
		avatarColor = ""
		avatarName = ""
		email = ""
		name = ""
		AuthService.instance.isLoggedIn = false
		AuthService.instance.userEmail = ""
		AuthService.instance.authToken = ""
		MessageService.instance.clearChannels()
		MessageService.instance.clearMessages()
	}
}
