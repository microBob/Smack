//
//  GradientView.swift
//  Smack
//
//  Created by Kenneth on 11/22/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
	
	@IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
		didSet {
			self.setNeedsLayout()
		}
	}
	@IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
		didSet {
			self.setNeedsLayout()
		}
	}
	
	override func layoutSubviews() {
		let gradLay = CAGradientLayer()
		
		gradLay.colors = [topColor.cgColor, bottomColor.cgColor]
		gradLay.startPoint = CGPoint(x: 0, y: 0)
		gradLay.endPoint = CGPoint(x: 1.0, y: 0.6)
		gradLay.frame = self.bounds
		
		self.layer.insertSublayer(gradLay, at: 0)
	}
}
