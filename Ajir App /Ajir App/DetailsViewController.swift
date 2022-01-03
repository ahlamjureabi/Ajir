//
//  DetailsViewController.swift
//  Ajir App
//
//  Created by Ahlam Ahlam on 24/05/1443 AH.
//

import UIKit

class DetailsViewController: UIViewController {

    var selectedPost:Post?
    var selectedPostImage:UIImage?
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDescriptionLabe: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedPost = selectedPost,
        let selectedImage = selectedPostImage {
         postTitleLabel.text = selectedPost.title
          postDescriptionLabe.text = selectedPost.description
            postImage.image = selectedImage
            
            
            
            
            
        }
    }
    


}

