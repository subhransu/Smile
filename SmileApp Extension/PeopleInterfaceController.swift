//
//  PeopleInterfaceController.swift
//  Smile
//
//  Created by Behera, Subhransu on 6/13/15.
//  Copyright © 2015 subhb.org. All rights reserved.
//

import WatchKit
import Foundation


class PeopleInterfaceController: WKInterfaceController {
  
  @IBOutlet var personTwoImage: WKInterfaceImage!
  @IBOutlet var personOneImg: WKInterfaceImage!
  @IBOutlet var personThreeImage: WKInterfaceImage!
  @IBOutlet var personFourImage: WKInterfaceImage!
  @IBOutlet var personFiveImage: WKInterfaceImage!
  
  @IBOutlet var peopleTable: WKInterfaceTable!
  
  @IBOutlet var peopleTableGroup: WKInterfaceGroup!
  @IBOutlet var peopleGridGroup: WKInterfaceGroup!
  
  var shuffleFlag = 1
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    // Configure interface objects here.
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    
    displayAnimationAfterShowingView()
    
    self.peopleTableGroup.setHeight(0)
    self.peopleTable.insertRowsAtIndexes(NSIndexSet(indexesInRange: NSMakeRange(0, 4)), withRowType: "PeopleRowType")
    
    let nameArray = ["Lora Brown", "John Smith", "Daisy Fox", "Eliza Sim"]
    let dateArray = ["04/20/2015", "04/09/2015", "03/18/2015", "03/10/2015"]

    for var index = 0; index < 4; ++index {
        if let row = self.peopleTable.rowControllerAtIndex(index) as? PeopleRowController {
          let patientIndex = index + 1
          row.peopleThumb.setImage(UIImage(named: "patient_\(patientIndex)"))
          row.peopleTitleLabel.setText(nameArray[index])
          row.dateLabel.setText(dateArray[index])
        }
    }
  }
  
  func displayAnimationAfterShowingView() {
    animateWithDuration(0.8) { () -> Void in
      self.personOneImg.setHidden(false)
      self.personTwoImage.setHidden(false)
      self.personThreeImage.setHidden(false)
      self.personFourImage.setHidden(false)
    }
  }
  
  @IBAction func shuffleBtnTapped() {
    if (shuffleFlag == 1) {
      shuffleFlag = 2
      
      animateWithDuration(0.3, animations: { () -> Void in
        self.peopleGridGroup.setHeight(0)
        self.peopleTableGroup.setHeight(180)
      })
    } else {
      shuffleFlag = 1
      
      self.peopleGridGroup.setHeight(180)
      self.peopleTableGroup.setHeight(0)
    }
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  
  
}
