//
//  postCell.swift
//  Ajir App
//
//  Created by Ahlam Ahlam on 25/05/1443 AH.
//

import UIKit
import Firebase
class postCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var postPhoneNumberLabel: UILabel!
    func configure(with post:Post) -> UITableViewCell {
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.description
        imageUser.loadImageUsingCache(with: post.user.imageUrl)
        postImageView.loadImageUsingCache(with: post.imageUrl)
        postPhoneNumberLabel.text = post.phone
        return self
    }
    
    override func prepareForReuse() {
        imageUser.image = nil
        postImageView.image = nil
     
    }
}

    
