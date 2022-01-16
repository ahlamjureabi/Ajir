//
//  Product.swift
//  Ajir App
//
//  Created by Ahlam Ahlam on 23/05/1443 AH.
//

import Foundation
import Firebase

struct Post {
    var id = ""
    var title = ""
    var description = ""
    var imageUrl = ""
    var phone = ""
    var address = ""
    var city = ""
    var user:User
    var createdAt:Timestamp?
    
    init(dict:[String:Any],id:String,user:User) {
        if let title = dict["title"] as? String,
           let description = dict["description"] as? String,
           let imageUrl = dict["imageUrl"] as? String,
           let phone = dict["phone"] as? String,
           let address = dict["address"] as? String,
           let city = dict["city"] as? String,
            let createdAt = dict["createdAt"] as? Timestamp{
            self.title = title
            self.description = description
            self.imageUrl = imageUrl
            self.phone = phone
            self.address = address
            self.city = city
            self.createdAt = createdAt
        }
        self.id = id
        self.user = user
    }
}
