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
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
        // Do any additional setup after loading the view.
    }


	func setupView() {
		usernameTxt.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
		passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
	}
	
	@IBAction func closePressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	@IBAction func createAccountPressed(_ sender: Any) {
		performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
	}
}
