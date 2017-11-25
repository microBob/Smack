//
//  ProfileVC.swift
//  Smack
//
//  Created by Kenneth on 11/25/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

	//MARK: outlets
	@IBOutlet weak var userImg: UIImageView!
	@IBOutlet weak var userName: UILabel!
	@IBOutlet weak var userEmail: UILabel!
	
	@IBOutlet weak var bgView: UIView!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		userImg.image = UIImage(named: UserDataService.instance.avatarName)
		userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
		
		userName.text = UserDataService.instance.name
		userEmail.text = UserDataService.instance.email
		
		let closeTouch = UITapGestureRecognizer(target: self, action: #selector(closeTap(_:)))
		bgView.addGestureRecognizer(closeTouch)
    }
	
	@objc func closeTap(_ recognizer: UITapGestureRecognizer){
		dismiss(animated: true, completion: nil)
	}

	@IBAction func logoutPressed(_ sender: Any) {
		UserDataService.instance.logoutUser()
		NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
		dismiss(animated: true, completion: nil)
	}
	@IBAction func closePressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
}
