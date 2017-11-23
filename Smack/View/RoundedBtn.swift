//
//  RoundedBtn.swift
//  Smack
//
//  Created by Kenneth on 11/23/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

class RoundedBtn: UIButton {
	@IBInspectable var cornerRad: CGFloat = 3.0 {
		didSet {
			self.layer.cornerRadius = cornerRad
		}
	}
	
	override func awakeFromNib() {
		self.setupView()
	}
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		self.setupView()
	}
	func setupView() {
		self.layer.cornerRadius = cornerRad
	}
}
