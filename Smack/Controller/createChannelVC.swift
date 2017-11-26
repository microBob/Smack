
//
//  createChannelVC.swift
//  Smack
//
//  Created by Kenneth on 11/26/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

class createChannelVC: UIViewController {

	//MARK: outlets
	@IBOutlet weak var nameTxt: UITextField!
	@IBOutlet weak var descripTxt: UITextField!
	@IBOutlet weak var bgView: UIView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		nameTxt.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
		descripTxt.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
		
		let closeTouch = UITapGestureRecognizer(target: self, action: #selector(createChannelVC.closeTap(_:)))
		bgView.addGestureRecognizer(closeTouch)
    }

	@objc func closeTap(_ recognizer: UITapGestureRecognizer) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func createPressed(_ sender: Any) {
		guard let chName = nameTxt.text , nameTxt.text != "" else { return }
		guard let chDesc = descripTxt.text else { return }
		
		SocketService.instance.addChannel(name: chName, description: chDesc) { (succ) in
			self.dismiss(animated: true, completion: nil)
		}
	}
	@IBAction func closePressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
}
