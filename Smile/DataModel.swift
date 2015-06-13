//
//  DataModel.swift
//  Smile
//
//  Created by Deen Aariff on 6/13/15.
//  Copyright (c) 2015 subhb.org. All rights reserved.
//

import Foundation

class Charities {
    var name: String
    var charities: [Charity]
    
    init(named:String, includeCharities: [Charity])
    {
        name = named;
        charities = includeCharities
    }
    
    class func charityList() -> [Charities]
    {
        return (self.myDonations())
    }

    private class func myDonations() -> Charities {
        charities.append(Charity(titled: "Foundation 1", description: "Support Breast Cancer Awarness", imageName: ""))
        charities.append(Charity(titled: "Foundation 2", description: "Feed Hungry Children", imageName: ""))
        charities.append(Charity(titled: "Foundation 3", description: "Education of Disadvantage children", imageName: ""))
        return Charities(named: "myDonations", includeCharities: charities)
    }
            
}
