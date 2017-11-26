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
	
	override func viewDidLoad() {
        super.viewDidLoad()

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
	func onLoginGetMessage() {
		MessageService.instance.findAllChannels { (succ) in
			if succ {
				
			}
		}
	}
	func updateWithChannels() {
		let chName = MessageService.instance.selectedChannel?.channelTitle ?? ""
		channelName.text = "#\(chName)"
	}
}
