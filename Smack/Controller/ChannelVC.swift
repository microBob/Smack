//
//  ChannelVC.swift
//  Smack
//
//  Created by Kenneth on 11/22/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

	//MARK: outlets
	@IBOutlet weak var addChannelBtn: UIButton!
	@IBOutlet weak var loginBtn: UIButton!
	@IBOutlet weak var userImage: CircleImage!
	@IBOutlet weak var channelTable: UITableView!
	
	@IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width * 5/6
		self.view.addConstraints([
			NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: addChannelBtn, attribute: .trailing, multiplier: 1, constant: self.view.frame.size.width * 1/4),
			NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: channelTable, attribute: .trailing, multiplier: 1, constant: self.view.frame.size.width * 1/4)
		])
		
		NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
	
	@objc func userDataDidChange(_ notif: Notification) {
		if AuthService.instance.isLoggedIn {
			loginBtn.setTitle(UserDataService.instance.name, for: .normal)
			userImage.image = UIImage(named: "\(UserDataService.instance.avatarName)")
			userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
		} else {
			loginBtn.setTitle("Login", for: .normal)
			userImage.image = UIImage(named: "menuProfileIcon")
			userImage.backgroundColor = UIColor.clear
		}
	}
	
	@IBAction func loginBtnPressed(_ sender: Any) {
		if AuthService.instance.isLoggedIn {
			let profile = ProfileVC()
			profile.modalPresentationStyle = .custom
			present(profile, animated: true, completion: nil)
		} else {
			performSegue(withIdentifier: TO_LOGIN, sender: nil)
		}
	}
}
