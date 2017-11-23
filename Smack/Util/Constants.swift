//
//  Constants.swift
//  Smack
//
//  Created by Kenneth on 11/22/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import Foundation


typealias CompletionHandler = (_ Success: Bool) -> ()

//MARK: Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

//MARK: User Default
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//MARK: URL constants
let BASE_URL = "https://smackchatsmack.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"

//MARK: header
let HEADER = [
	"Content-Type": "application/json; charset=utf-8"
]
