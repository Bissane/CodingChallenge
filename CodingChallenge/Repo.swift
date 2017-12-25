//
//  Repo.swift
//  CodingChallenge
//
//  Created by mac on 12/19/17.
//  Copyright © 2017 Bissane. All rights reserved.
//

import Foundation

class repo {

    var name : String
    var desc : String
    var ownerName : String
    var rating : String
    var ownerAvatarUrl : String
    
    init(name : String, desc : String, ownerName : String, rating : String, ownerAvatarUrl : String){
        self.name = name
        self.desc = desc
        self.ownerName = ownerName
        self.rating = rating
        self.ownerAvatarUrl = ownerAvatarUrl
        
        
    }

}
