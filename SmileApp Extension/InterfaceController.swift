//
//  InterfaceController.swift
//  SmileApp Extension
//
//  Created by Behera, Subhransu on 6/13/15.
//  Copyright © 2015 subhb.org. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
  @IBOutlet var amountPicker: WKInterfacePicker!
  @IBOutlet var donationLabel: WKInterfaceLabel!
  @IBOutlet var donationMainGroup: WKInterfaceGroup!
  @IBOutlet var donationConfirmationGroup: WKInterfaceGroup!
  @IBOutlet var confirmationLabel: WKInterfaceLabel!
  @IBOutlet var infoGroup: WKInterfaceGroup!
  
  var amountPickerArray : [WKPickerItem] = []
  var donationAmountString : String = ""
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    let itemOne = WKPickerItem()
    itemOne.title = "1"
    amountPickerArray.append(itemOne)
    
    let itemTwo = WKPickerItem()
    itemTwo.title = "5"
    amountPickerArray += [itemTwo]
    
    let itemThree = WKPickerItem()
    itemThree.title = "10"
    amountPickerArray += [itemThree]
    
    let itemFour = WKPickerItem()
    itemFour.title = "20"
    amountPickerArray += [itemFour]
    
    self.amountPicker.setItems(amountPickerArray)
    
    amountPicker.setSelectedItemIndex(0)
    self.donationLabel.setText("Donate: $1")
    
    self.donationMainGroup.setHeight(0)
    self.donationConfirmationGroup.setHeight(0)
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  @IBAction func pickerValueChanged(value: Int) {
      let donationAmount = amountPickerArray[value].title
      donationAmountString = donationAmount!
    
      let donationText = "Donate: $\(donationAmount!)"
      self.donationLabel.setText(donationText)
  }
  
  @IBAction func homeBtnTapped() {
    amountPicker.setSelectedItemIndex(0)
    self.donationLabel.setText("Donate: $1")
    
    animateWithDuration(0.3) { () -> Void in
      self.infoGroup.setHeight(180)
      self.donationMainGroup.setHeight(0)
      self.donationConfirmationGroup.setHeight(0)
    }
  }
  
  @IBAction func firstDonateBtnTapped() {
    animateWithDuration(0.3) { () -> Void in
      self.infoGroup.setHeight(0)
      self.donationMainGroup.setHeight(180)
      self.donationConfirmationGroup.setHeight(0)
    }
  }
  
  @IBAction func donateBtnTapped() {
    
    self.confirmationLabel.setText("$\(donationAmountString)")

    animateWithDuration(0.3) { () -> Void in
      self.infoGroup.setHeight(0)
      self.donationMainGroup.setHeight(0)
      self.donationConfirmationGroup.setHeight(180)
    }
  }
}
