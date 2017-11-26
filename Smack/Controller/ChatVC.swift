//
//  ChatVC.swift
//  Smack
//
//  Created by Kenneth on 11/22/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
	
	//MARK: Outlets
	@IBOutlet weak var menuBtn: UIButton!
	@IBOutlet weak var channelName: UILabel!
	@IBOutlet weak var messageTxt: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		view.bindToKeyboard()
		
		menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
		self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
		
		NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
		
		
		if AuthService.instance.isLoggedIn {
			AuthService.instance.findUserByEmail(completion: { (succ) in
				if succ {
					NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
				}
			})
		}
		MessageService.instance.findAllChannels { (succ) in
			if succ {
				print("Got Channels")
			} else {
				print("Didn't get Channels")
			}
		}
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		view.addGestureRecognizer(tap)
    }
	
	@objc func userDataDidChange(_ notif: Notification) {
		if AuthService.instance.isLoggedIn {
			onLoginGetMessage()
			channelName.text = "Smack"
		} else {
			channelName.text = "Please Login"
		}
	}
	@objc func channelSelected(_ notif: Notification) {
		updateWithChannels()
	}
	@objc func handleTap() {
		view.endEditing(true)
	}
	func onLoginGetMessage() {
		MessageService.instance.findAllChannels { (succ) in
			if succ {
				if MessageService.instance.channels.count > 0 {
					MessageService.instance.selectedChannel = MessageService.instance.channels[0]
					self.updateWithChannels()
				} else {
					self.channelName.text = "No channels yet"
				}
			}
		}
	}
	func updateWithChannels() {
		let chName = MessageService.instance.selectedChannel?.channelTitle ?? ""
		channelName.text = "#\(chName)"
		getMessagaes()
	}
	func getMessagaes(){
		guard let channelId = MessageService.instance.selectedChannel?.id else {return}
		MessageService.instance.findAllMessagesForChannel(channelID: channelId) { (succ) in
			if succ {
				
			}else {
				
			}
		}
	}
	@IBAction func sendMessagePressed(_ sender: Any) {
		if AuthService.instance.isLoggedIn {
			guard let chId = MessageService.instance.selectedChannel?.id else {return}
			guard let mess = messageTxt.text else {return}
			
			SocketService.instance.addMessage(messageBod: mess, userId: UserDataService.instance.id, channelId: chId, completion: { (succ) in
				if succ {
					self.messageTxt.text = ""
					self.messageTxt.resignFirstResponder()
				}
			})
		}
	}
}
