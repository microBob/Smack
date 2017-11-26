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
let TO_AVATAR_PICKER = "toAvatarPicker"

//MARK: User Default
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//MARK: URL constants
let BASE_URL = "https://smackchatsmack.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_ADD_USER = "\(BASE_URL)user/add"
let URL_FIND_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"

//MARK: header
let HEADER = [
	"Content-Type": "application/json; charset=utf-8"
]
let BEARER_HEADER = [
	"Authorization":"Bearer \(AuthService.instance.authToken)",
	"Content-Type": "application/json; charset=utf-8"
]

//MARK: colors
let smackPurplePlaceholder = #colorLiteral(red: 0.3254901961, green: 0.4215201139, blue: 0.7752227187, alpha: 0.5)

//MARK: notif
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("UserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("ChannelsLoaded")
let NOTIF_CHANNELS_SELECTED = Notification.Name("ChannelsSelected")

//MARK: socket event keys
let SOCKET_NEW_CHANNEL = "newChannel"
let SOCKET_CHANNEL_CREATED = "channelCreated"
