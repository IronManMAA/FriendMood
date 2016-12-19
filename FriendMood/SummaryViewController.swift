//
//  DetailFriendMoodTableViewController.swift
//  FriendMood
//
//  Created by Marco Almeida on 12/14/16.
//  Copyright © 2016 THE IRON YARD. All rights reserved.
//

import Foundation
import UIKit


//  ViewTwo.swift

class SummaryViewController: UIViewController
{
    @IBOutlet var summaryTitle: UILabel!
    @IBOutlet var friendNameLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityTempLabel: UILabel!
    @IBOutlet var cityTempAlertsLabel: UILabel!
    @IBOutlet var cityTempDeviationLabel: UILabel!
    @IBOutlet var ImageTemp: UIImageView!

    var friendNameSague = String()
    var friendNameIDSague = String()
    var cityNameSague = String()
    var cityTempSague = String()
    var cityTempAlertsSague = String()
    var cityTempDeviationSague = String()
    
  override func viewWillAppear(_ animated: Bool){

     self.friendNameLabel.text = self.friendNameSague
     self.cityNameLabel.text = self.cityNameSague
     self.cityTempAlertsLabel.text = self.cityTempAlertsSague
     self.cityTempLabel.text = ("\(self.cityTempSague)°F")
     self.cityTempDeviationLabel.text = ("\(self.cityTempDeviationSague)°F")

    let tempST = Int(self.cityTempSague)
    if tempST != nil {
    if (tempST! > 70) {
    //print("Hot - \(fN) - \(cN) - \(cT)")
    ImageTemp.image  = UIImage(named: "hot")
    } else {
    if (tempST! < 50) {
    //print("Cold - \(fN) - \(cN) - \(cT)")
    ImageTemp.image  = UIImage(named: "cold")!
    } else {
    //print("Normal - \(fN) - \(cN) - \(cT)")
    ImageTemp.image  = UIImage(named: "partly")! }
    }
    }
    
  }

    // Segue Controllers  ********************************************
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("Got up to here-4")
        if segue.identifier == "DetailFriendViewControllerSegue"
        {
            if let destinationVC = segue.destination as? FriendViewController {
                destinationVC.friendNameIDSague = self.friendNameIDSague
                destinationVC.friendNameSague = self.friendNameLabel.text!
                destinationVC.cityNameSague = self.cityNameLabel.text!
                destinationVC.cityTempDeviationSague = self.cityTempDeviationLabel.text!
            }
        }
    }
    // End of Segue Controllers  ********************************************
    
override func viewDidLoad() {
    //print("Got up to here- FINAL!")
}


} // end of Class

