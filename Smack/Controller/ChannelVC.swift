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
	@IBOutlet weak var channelTable: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width * 5/6
		
		self.view.addConstraints([
			NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: addChannelBtn, attribute: .trailing, multiplier: 1, constant: self.view.frame.size.width * 1/4),
			NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: channelTable, attribute: .trailing, multiplier: 1, constant: self.view.frame.size.width * 1/4)
		])
    }

	@IBAction func loginBtnPressed(_ sender: Any) {
		performSegue(withIdentifier: TO_LOGIN, sender: nil)
	}
}
