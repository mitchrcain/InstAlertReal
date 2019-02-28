//
//  PostCell.swift
//  InstAlert
//
//  Created by Mitchell Cain on 1/25/19.
//  Copyright © 2019 Mitchell Cain. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likePost: UIImageView!
    @IBOutlet weak var commentButton: UIImageView!
    @IBOutlet weak var sendButton: UIImageView!
    @IBOutlet weak var likes: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let likeTapGesture = UITapGestureRecognizer(target: self.likePost, action: #selector(fillHeart))
        likePost.addGestureRecognizer(likeTapGesture)
        likePost.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func fillHeart(cell: PostCell) {
        if cell.likePost.image == UIImage(named: "heartFull") {
            cell.likePost.image = UIImage(named: "heartEmpty")
        } else {
            cell.likePost.image = UIImage(named: "heartFull")
        }
    }
    
    
    
    
    
    

}
