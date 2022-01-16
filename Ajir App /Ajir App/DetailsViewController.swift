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
    
    @IBOutlet weak var viewDetelid: UIView!
    
    @IBOutlet weak var translateTitle: UILabel!{
        didSet {

         translateTitle.text = "Title".localized
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var postTitleLabel: UILabel!
        
     
    
    @IBOutlet weak var translateDescription: UILabel! {
        
        didSet {

          translateDescription.text = "Description".localized
        }
    }
    
    @IBOutlet weak var postDescriptionLabe: UILabel!
    
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var translatePhone: UILabel!{
        
        didSet {

        translatePhone.text = "phone".localized
        }
    }
   
    @IBOutlet weak var postPhoneLabel: UILabel!

    @IBOutlet weak var translateCity: UILabel!{
    
    didSet {

    translateCity.text = "City".localized
    }
}
    @IBOutlet weak var postCityLabel: UILabel!
    

    @IBOutlet weak var translateAddress: UILabel!{
        
        didSet {

translateAddress.text = "Address".localized
        }
    }
    
  
    
    @IBOutlet weak var postAddressLabel: UILabel!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedPost = selectedPost,
        let selectedImage = selectedPostImage {
         postTitleLabel.text = selectedPost.title
          postDescriptionLabe.text = selectedPost.description
            postPhoneLabel.text = selectedPost.phone
            postCityLabel.text = selectedPost.city
            postAddressLabel.text = selectedPost.address
            postImage.image = selectedImage
            
            
            
          
            
        }
        viewDetelid.layer.cornerRadius = 60
        viewDetelid.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
       imageView.layer.cornerRadius = 60
        imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        
    }
    


}

