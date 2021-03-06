//
//  ChannelVC.swift
//  Smack
//
//  Created by Kenneth on 11/22/17.
//  Copyright © 2017 Microbob. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

	//MARK: outlets
	@IBOutlet weak var addChannelBtn: UIButton!
	@IBOutlet weak var loginBtn: UIButton!
	@IBOutlet weak var userImage: CircleImage!
	@IBOutlet weak var channelTable: UITableView!
	
	@IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		channelTable.delegate = self
		channelTable.dataSource = self
		
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width * 5/6
		self.view.addConstraints([
			NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: addChannelBtn, attribute: .trailing, multiplier: 1, constant: self.view.frame.size.width * 1/4),
			NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: channelTable, attribute: .trailing, multiplier: 1, constant: self.view.frame.size.width * 1/4)
		])
		
		NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
		
		SocketService.instance.getChannel { (succ) in
			if succ {
				self.channelTable.reloadData()
			}
		}
    }
	
	override func viewDidAppear(_ animated: Bool) {
		setUserInfo()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return MessageService.instance.channels.count
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
			let channel = MessageService.instance.channels[indexPath.row]
			cell.configCell(channel: channel)
			
			return cell
		} else {
			return UITableViewCell()
		}
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let channel = MessageService.instance.channels[indexPath.row]
		MessageService.instance.selectedChannel = channel
		
		NotificationCenter.default.post(name: NOTIF_CHANNELS_SELECTED, object: nil)
		
		self.revealViewController().revealToggle(animated: true)
	}
	
	@objc func userDataDidChange(_ notif: Notification) {
		setUserInfo()
	}
	@objc func channelsLoaded(_ notif: Notification) {
		channelTable.reloadData()
	}
	func setUserInfo() {
		if AuthService.instance.isLoggedIn {
			loginBtn.setTitle(UserDataService.instance.name, for: .normal)
			userImage.image = UIImage(named: "\(UserDataService.instance.avatarName)")
			userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
		} else {
			loginBtn.setTitle("Login", for: .normal)
			userImage.image = UIImage(named: "menuProfileIcon")
			userImage.backgroundColor = UIColor.clear
			channelTable.reloadData()
		}
	}
	
	@IBAction func createChannel(_ sender: Any) {
		if AuthService.instance.isLoggedIn {
			let createChannel = createChannelVC()
			createChannel.modalPresentationStyle = .custom
			present(createChannel, animated: true, completion: nil)
		}		
	}
	@IBAction func loginBtnPressed(_ sender: Any) {
		if AuthService.instance.isLoggedIn {
			let profile = ProfileVC()
			profile.modalPresentationStyle = .custom
			present(profile, animated: true, completion: nil)
		} else {
			performSegue(withIdentifier: TO_LOGIN, sender: nil)
		}
	}
}
