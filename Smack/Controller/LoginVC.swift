//
//  LoginVC.swift
//  Smack
//
//  Created by Kenneth on 11/22/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

	//MARK: outlets
	@IBOutlet weak var usernameTxt: UITextField!
	@IBOutlet weak var passwordTxt: UITextField!
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
        // Do any additional setup after loading the view.
    }


	func setupView() {
		spinner.isHidden = true
		spinner.stopAnimating()
		usernameTxt.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
		passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
	}
	
	@IBAction func loginPressed(_ sender: Any) {
		spinner.isHidden = false
		spinner.startAnimating()
		
		guard let email = usernameTxt.text , usernameTxt.text != "" else {return}
		guard let pass = passwordTxt.text , passwordTxt.text != "" else {return}
		
		AuthService.instance.loginUser(email: email, password: pass) { (succ) in
			if succ {
				AuthService.instance.findUserByEmail(completion: { (succ) in
					if succ {
						AuthService.instance.isLoggedIn = true
						NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
						
						self.spinner.isHidden = true
						self.spinner.stopAnimating()
						self.dismiss(animated: true, completion: nil)
					}
				})
			}
		}
		
	}
	@IBAction func closePressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	@IBAction func createAccountPressed(_ sender: Any) {
		performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
	}
}
