//
//  ChannelCell.swift
//  Smack
//
//  Created by Kenneth on 11/25/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

	//MARK: Outlets
	@IBOutlet weak var channelName: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		if selected {
			self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
		} else {
			self.layer.backgroundColor = UIColor.clear.cgColor
		}
    }
	
	func configCell(channel: Channel) {
		let title = channel.channelTitle ?? ""
		channelName.text = "#\(title)"
	}
}
