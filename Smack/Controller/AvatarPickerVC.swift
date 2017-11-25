//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Kenneth on 11/23/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	//MARK: Outlets
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var segControl: UISegmentedControl!
	
	//MARK: vars
	var avatarTypeVar = avatarType.dark
	
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
		collectionView.dataSource = self
		
    }
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? avatarCell{
			cell.configureCell(index: indexPath.item, type: avatarTypeVar)
			return cell
		}
		return UICollectionViewCell()
	}
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 28
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		var numOfCol: CGFloat = 3
		
		if UIScreen.main.bounds.width > 320 {
			numOfCol = 4
		}
		
		let spaceBetween: CGFloat = 10
		let padding: CGFloat = 40
		let cellDim = ((collectionView.bounds.width - padding) - (numOfCol - 1) * spaceBetween) / numOfCol
		
		return CGSize(width: cellDim, height: cellDim)
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if avatarTypeVar == .dark {
			UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
		} else {
			UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
		}
		
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func backPressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	@IBAction func segControlChanged(_ sender: Any) {
		if segControl.selectedSegmentIndex == 0 {
			avatarTypeVar = .dark
		} else {
			avatarTypeVar = .light
		}
		
		collectionView.reloadData()
	}
	
}
