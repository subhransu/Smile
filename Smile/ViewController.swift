//
//  ViewController.swift
//  Smile
//
//  Created by Behera, Subhransu on 6/13/15.
//  Copyright © 2015 subhb.org. All rights reserved.
//

import UIKit


struct Charity {
    var name: String;
    var cause: String;
    var imageName: String;
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
  let charities = [
    Charity(name: "Charity One", cause: "test", imageName: "patient_1.png"),
    Charity(name: "Charity Two", cause: "test", imageName: "patient_2.png"),
    Charity(name: "Charity Three", cause: "test", imageName: "patient_3.png"),
    Charity(name: "Charity Four", cause: "test", imageName: "patient_4.png"),
    Charity(name: "Charity Five",cause: "test", imageName: "patient_5.png")
  ]
    
  @IBOutlet weak var tableView: UITableView!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"Cell")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let charity = self.charities[indexPath.row]
        let tableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "")
        tableViewCell.textLabel!.text = charity.name
        tableViewCell.imageView!.image = UIImage(named: charity.imageName)
        tableViewCell.detailTextLabel?.text = charity.cause
        return tableViewCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }



}

