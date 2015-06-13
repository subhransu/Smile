//
//  DonationTableViewController.swift
//  Smile
//
//  Created by Deen Aariff on 6/13/15.
//  Copyright (c) 2015 subhb.org. All rights reserved.
//

import Foundation
import UIKit

class DonationTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var charities: [Charity] {
        var charityList = Charities.charityList()
        return charityList[0].charities;
    }
    
    override func numberofSectionsinTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberofRowsinSection section: Int) -> Int {
        return charities.count
    }
    
    // indexpath: which seciton and which path
    override func tableView(tableView: UITableView, cellForRowatIndexPath indexPath: NSIndexPath) ->  UITableViewCell {
        left cell = tableView.dequeueReusableCellwithIndentifier("Product Cell", forIndexPath: indexPath) as UITableView; Cell
            let charity = charities[IndexPath.row]
            cell.textTable?.text = charity.name
            cell.detailTextLabel?.text = charity.cause
            cell.imageView?.image = charity.image
        return cell
    }

}
