//
//  avatarCell.swift
//  Smack
//
//  Created by Kenneth on 11/23/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

class avatarCell: UICollectionViewCell {
	@IBOutlet weak var avatarImg: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setupView()
	}
	
	func setupView(){
		self.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
		self.layer.cornerRadius = 10
		self.clipsToBounds = true
	}
	
}
