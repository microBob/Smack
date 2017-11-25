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
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	
	//MARK: default vars
	var avatarName = "profileDefault"
	var avatarColor = "[0.5, 0.5, 0.5, 1]"
	var bgColor: UIColor?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
        // Do any additional setup after loading the view.
    }
	override func viewDidAppear(_ animated: Bool) {
		if UserDataService.instance.avatarName != "" {
			userImg.image = UIImage(named: UserDataService.instance.avatarName)
			avatarName = UserDataService.instance.avatarName
		}
		
		if avatarName.contains("light") {
			userImg.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
		}
	}

	@IBAction func createAccountPressed(_ sender: Any) {
		spinner.isHidden = false
		spinner.startAnimating()
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
								self.spinner.isHidden = true
								self.spinner.stopAnimating()
								
								NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
								self.performSegue(withIdentifier: UNWIND, sender: nil)
							}
						})
					}
				})
			}
		}
	}
	@IBAction func chooseAvatarPressed(_ sender: Any) {
		performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
	}
	@IBAction func genBgColorPressed(_ sender: Any) {
		let r = CGFloat(arc4random_uniform(255)) / 255
		let g = CGFloat(arc4random_uniform(255)) / 255
		let b = CGFloat(arc4random_uniform(255)) / 255
		
		bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
		
		UIView.animate(withDuration: 0.2){
			self.userImg.backgroundColor = self.bgColor
		}
	}
	
	func setupView() {
		spinner.isHidden = true

		usernameTxt.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
		emailTxt.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
		passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		view.addGestureRecognizer(tap)
	}
	@objc func handleTap() {
		view.endEditing(true)
	}
	
	@IBAction func closePressed(_ sender: Any) {
		performSegue(withIdentifier: UNWIND, sender: nil)
	}
}
