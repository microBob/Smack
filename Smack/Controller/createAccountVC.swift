//
//  createAccountVC.swift
//  Smack
//
//  Created by Kenneth on 11/22/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

class createAccountVC: UIViewController {

	//MARK: Outlets
	@IBOutlet weak var usernameTxt: UITextField!
	@IBOutlet weak var emailTxt: UITextField!
	@IBOutlet weak var passwordTxt: UITextField!
	
	@IBOutlet weak var userImg: UIImageView!
	
	
	//MARK: default vars
	var avatarName = "profileDefault"
	var avatarColor = "[0.5, 0.5, 0.5, 1]"
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	@IBAction func createAccountPressed(_ sender: Any) {
		guard let email = emailTxt.text , emailTxt.text != "" else { return }
		guard let password = passwordTxt.text , passwordTxt.text != "" else { return }
		guard let name = usernameTxt.text , usernameTxt.text != "" else { return }
		
		AuthService.instance.registerUser(email: email, password: password) { (succ) in
			if succ {
				AuthService.instance.loginUser(email: email, password: password, completion: { (succ) in
					if succ {
						AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (succ) in
							if succ {
								print(UserDataService.instance.name, UserDataService.instance.avatarName)
								self.performSegue(withIdentifier: UNWIND, sender: nil)
							}
						})
					}
				})
			}
		}
	}
	@IBAction func chooseAvatarPressed(_ sender: Any) {
	}
	@IBAction func genBgColorPressed(_ sender: Any) {
	}
	
	@IBAction func closePressed(_ sender: Any) {
		performSegue(withIdentifier: UNWIND, sender: nil)
	}
}
