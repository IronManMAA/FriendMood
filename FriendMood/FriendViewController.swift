//
//  FriendViewController.swift
//  FriendMood
//
//  Created by Marco Almeida on 12/18/16.
//  Copyright © 2016 THE IRON YARD. All rights reserved.
//

import Foundation
import UIKit


class FriendViewController: UIViewController
{

    @IBOutlet weak var TempPercentSlider: UISlider!
    @IBOutlet var tempPercentLabel : UILabel!
    @IBOutlet var PerExample : UILabel!
    @IBOutlet var cityTempDeviationLabel : UILabel!
    @IBOutlet var friendNameText : UITextField!
    @IBOutlet var cityNameText : UITextField!
    @IBOutlet weak var Clear: UIButton!
    @IBOutlet weak var Save: UIButton!
    var friendNameSague = String()
    var friendNameIDSague = String()
    var cityNameSague = String()
    var cityTempDeviationSague = String()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        PerExample.text = "e.g. 100% deviation of average temperature of 50°F means below 0°F or above 100°F"
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func changePercentage(_ sender: UISlider) {
        let tempPercentage = Double(TempPercentSlider.value) / 100.0
        tempPercentLabel.text = String(format: "(%.0f%%)", tempPercentage * 100.0)
        // (%.0f%%) used to format the output data with the % sign

    }

    @IBAction func Clear(_ sender : AnyObject)
    {
        tempPercentLabel.text = "0"
        self.friendNameText.text = ""
        self.cityNameText.text = ""
        TempPercentSlider.value = 0
    }

    @IBAction func Save(_ sender : AnyObject)
    {
print("Before ID: \(self.friendNameIDSague)")
print(nID)
print("Before name: \(self.friendNameSague)")
print("Before City: \(self.cityNameSague)")
        if (self.friendNameIDSague == "" && self.friendNameSague != "" && self.cityNameSague != "")
        { self.friendNameIDSague = "new"
print("New ID: \(self.friendNameIDSague)")
    }
    }

var nID = ""
    override func viewWillAppear(_ animated: Bool){
        nID = self.friendNameIDSague
        self.friendNameText.text = self.friendNameSague
        self.cityNameText.text = self.cityNameSague
        self.cityTempDeviationLabel.text = self.cityTempDeviationSague
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BacktoHomeSague"
        {
            if let destinationVC = segue.destination as? FriendMoodTableViewController {
print("Sague ID: \(self.friendNameIDSague)")
                destinationVC.friendNameIDSague = self.friendNameIDSague
                destinationVC.friendNameSague = self.friendNameText.text!
                destinationVC.cityNameSague = self.cityNameText.text!
                destinationVC.cityTempDeviationSague = self.tempPercentLabel.text!

            }
        }
    } // End of Segue Controllers  ********************************************

    
}  // End of Class
