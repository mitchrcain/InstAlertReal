//
//  ViewController.swift
//  InstAlert
//
//  Created by Mitchell Cain on 1/17/19.
//  Copyright © 2019 Mitchell Cain. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    var profilePictures = ["profileImage1.jpg", "profileImage2.jpg", "profileImage3.jpg"]
    var usernameList = ["Karol Jennings", "Amari Suarez", "Todd Cornish"]
    var postImages = ["postImage1.jpg", "postImage2.jpg", "postImage3.jpg"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        cell.postImage.image = UIImage(named: postImages[indexPath.row])
        cell.profileImageView.image = UIImage(named: profilePictures[indexPath.row])
        cell.username.text = usernameList[indexPath.row]
        if (indexPath.row)%2 == 1 {
            cell.commentButton.image = UIImage(named: "commentFull")
        }
        return cell
    }


}

