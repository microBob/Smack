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
	
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
		collectionView.dataSource = self
		
    }
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? avatarCell{
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
	
	@IBAction func backPressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	@IBAction func segControlChanged(_ sender: Any) {
	}
	
}
