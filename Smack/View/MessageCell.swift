//
//  MessageCell.swift
//  Smack
//
//  Created by Kenneth on 11/26/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

	//MARK: outlets
	@IBOutlet weak var userImg: CircleImage!
	@IBOutlet weak var username: UILabel!
	@IBOutlet weak var timeStamp: UILabel!
	@IBOutlet weak var messageBody: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	func configCell(message: Message) {
		messageBody.text = message.message
		username.text = message.userName
		userImg.image = UIImage(named: message.userAvatar)
		userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
	}

}
