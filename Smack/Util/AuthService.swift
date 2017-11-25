//
//  AuthService.swift
//  Smack
//
//  Created by Kenneth on 11/23/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
	static let instance = AuthService()
	
	let defaults = UserDefaults.standard
	
	var isLoggedIn: Bool {
		get {
			return defaults.bool(forKey: LOGGED_IN_KEY)
		}
		set {
			defaults.set(newValue, forKey: LOGGED_IN_KEY)
		}
	}
	var authToken: String {
		get {
			return defaults.value(forKey: TOKEN_KEY) as! String
		}
		set {
			defaults.set(newValue, forKey: TOKEN_KEY)
		}
	}
	var userEmail: String {
		get {
			return defaults.value(forKey: USER_EMAIL) as! String
		}
		set {
			defaults.set(newValue, forKey: USER_EMAIL)
		}
	}
	
	
	func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
		let lowerCaseEmail = email.lowercased()
		let body: [String: Any] = [
			"email": lowerCaseEmail,
			"password": password
		]
		
		Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
			if response.result.error == nil {
				completion(true)
			} else {
				completion(false)
				debugPrint(response.result.error as Any)
			}
		}
	}
	func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
		let lowerCaseEmail = email.lowercased()
		let body: [String: Any] = [
			"email": lowerCaseEmail,
			"password": password
		]
		
		Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (resp) in
			if resp.result.error == nil {
				guard let data = resp.data else { return }
				let json = JSON(data: data)
				
				self.userEmail = json["user"].stringValue
				self.authToken = json["token"].stringValue
				
				completion(true)
			}else {
				completion(false)
				debugPrint(resp.result.error as Any)
			}
		}
	}
	func setUserInfoData(data: Data) {
		let json = JSON(data: data)
		UserDataService.instance.setUserData(id: json["_id"].stringValue, color: json["avatarColor"].stringValue, avatarName: json["avatarName"].stringValue, email: json["email"].stringValue, name: json["name"].stringValue)
	}
	func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler){
		let lowerCaseEmail = email.lowercased()
		let body: [String: Any] = [
			"name": name,
			"email": lowerCaseEmail,
			"avatarName": avatarName,
			"avatarColor": avatarColor
		]
		
		Alamofire.request(URL_ADD_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (resp) in
			if resp.result.error == nil {
				guard let data = resp.data else { return }
				self.setUserInfoData(data: data)
				
				completion(true)
			}else {
				completion(false)
				debugPrint(resp.result.error as Any)
			}
		}
	}
	func findUserByEmail(completion: @escaping CompletionHandler) {
		Alamofire.request("\(URL_FIND_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (resp) in
			guard let data = resp.data else { return }
			self.setUserInfoData(data: data)
			
			completion(true)
		}
	}
	
}
