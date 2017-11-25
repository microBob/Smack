//
//  CircleImage.swift
//  Smack
//
//  Created by Kenneth on 11/24/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {

	override func awakeFromNib() {
		self.layer.cornerRadius = self.frame.width / 2
		self.clipsToBounds = true
	}

}
