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
	
	override func viewDidLoad() {
        super.viewDidLoad()

		menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
		self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
		
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
}
