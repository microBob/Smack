//
//  avatarCell.swift
//  Smack
//
//  Created by Kenneth on 11/23/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

enum avatarType {
	case dark
	case light
}

class avatarCell: UICollectionViewCell {
	@IBOutlet weak var avatarImg: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setupView()
	}
	
	func configureCell(index: Int, type: avatarType) {
		if type == avatarType.dark {
			avatarImg.image = UIImage(named: "dark\(index)")
			self.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		} else {
			avatarImg.image = UIImage(named: "light\(index)")
			self.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
		}
	}
	func setupView() {
		self.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		self.layer.cornerRadius = 10
		self.clipsToBounds = true
	}
	
}
