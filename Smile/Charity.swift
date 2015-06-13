//
//  Charity.swift
//  Smile
//
//  Created by Deen Aariff on 6/13/15.
//  Copyright (c) 2015 subhb.org. All rights reserved.
//

import Foundation

class Charity {
    var name: String
    var cause: String
    var donated: double
    var image: UIImage
    
    init (name: String, cause:String, imageName: String)
    {
        self.name = titled
        self.cause = description
        if let img = UIImage(named, imageName) {
            image = img
        } else {
            image = UIImage(named: "default")
        }
    }
}
