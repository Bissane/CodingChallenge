//
//  Repo.swift
//  CodingChallenge
//
//  Created by mac on 12/19/17.
//  Copyright © 2017 Bissane. All rights reserved.
//

import Foundation
import UIKit

class Repo {

    var name : String?
    var desc : String?
    var ownerName : String?
    var rating : String?
    var ownerAvatarUrl : String?
    var ownerAvatar : UIImage?
    
    init() {
        
    }
    
//    init(name : String, desc : String, ownerName : String, rating : String, ownerAvatarUrl : String){
//        self.name = name
//        self.desc = desc
//        self.ownerName = ownerName
//        self.rating = rating
//        self.ownerAvatarUrl = ownerAvatarUrl
//
//        OperationQueue.init().addOperation {
//            let data = NSData(contentsOf: (URL.init(string: self.ownerAvatarUrl))!)
//            self.ownerAvatar = UIImage(data: data! as Data)
//        }
//    }
}
