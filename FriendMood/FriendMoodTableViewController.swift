//
//  FriendMoodTableViewController.swift
//  FriendMood
//
//  Created by Marco Almeida on 12/14/16.
//  Copyright © 2016 THE IRON YARD. All rights reserved.
//

import UIKit
import CoreLocation

class FriendMoodTableViewController: UITableViewController
    //, UITableViewDataSource, UITableViewDelegate
{
    var aCityTemp = [CityTemps]()
    var friendsArray = [Friend]()
    var currentTemp = ""
    var currentTempAlerts = ""

    override func viewDidLoad() {
        super.viewDidLoad()    // do things here before window is visible to users
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if unarchiveFriends() == false    // to populate, turn this to TRUE & allow to save in tableview.
        {
        self.friendsArray.removeAll()
        let friend1 = Friend(friendNameID: "1", friendName: "Marco Almeida", city: "Orlando, Florida", temperature: "", coordinates: "28.4810971,-81.5088354", timezone: "Florida", alerts: "Alerts", deviation: "10")
        let friend2 = Friend(friendNameID: "2", friendName: "Simone Alves", city: "Rio De Janeiro, Brazil", temperature: "", coordinates: "-22.0622467,-44.0446482", timezone: "Brazil", alerts: "Alerts", deviation: "10")
        let friend3 = Friend(friendNameID: "3", friendName: "Pietro Polles", city: "Paris, France", temperature: "", coordinates: "48.8588377,2.2770195", timezone: "France", alerts: "Alerts", deviation: "10")
        let friend4 = Friend(friendNameID: "4", friendName: "Cristiana Freitas", city: "Berlin, Germany", temperature: "", coordinates: "52.5072111,13.1459682", timezone: "Germany", alerts: "Alerts", deviation: "10")
        let friend5 = Friend(friendNameID: "5", friendName: "Brian McNeill", city: "New York, NY", temperature: "", coordinates: "38.899265,-77.1546508", timezone: "USA", alerts: "Alerts", deviation: "10")
        friendsArray.append(friend5)
        friendsArray.append(friend4)
        friendsArray.append(friend3)
        friendsArray.append(friend2)
        friendsArray.append(friend1)

        }
 
// Check presence of address and coordinates in records
        for i in 0 ..< friendsArray.count  {
            let c = friendsArray[i].coordinates
            let a = friendsArray[i].city
            if c == "" {
                self.getGeocoderData(a, indexArray: i)
                print("empty")
            } else {
                self.searchWeatherFor(c, indexArray: i)
            }
        }
        
        
    } // end of ViewDidLoad

    
    func loadTemp(indexArray: Int)
    {
        let citytemp = self.aCityTemp[0]
        self.currentTemp = citytemp.temperature
        self.currentTempAlerts = citytemp.alerts
//print("current temp1: \(self.currentTemp)")
//print("current temp1: \(self.currentTempAlerts)")

        friendsArray[indexArray].temperature = self.currentTemp
        friendsArray[indexArray].alerts = self.currentTempAlerts
        
//print("current temp2: \(friendsArray[indexArray].temperature)")
        
//               self.archiveFriends()
        self.tableView.reloadData()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    

    
    func searchWeatherFor(_ myCoordinates: String, indexArray: Int)
    {
            let urlPath = "https://api.darksky.net/forecast/KEYGOESHERE/\(myCoordinates)"
            let url = URL(string: urlPath)!            // convert the urlPath string into a URL
            let session = URLSession.shared            // session information returned by apple
            let task = session.dataTask(with: url, completionHandler: {
                data, response, error in
                if error != nil
                {
                    print(error!.localizedDescription)
                }
                else if let dictionary = self.parseJSON(data!)
                {
                self.aCityTemp.removeAll()
                self.aCityTemp = CityTemps.citiesWithJSON(dictionary)
                    
                    let iA = indexArray
                    self.loadTemp(indexArray: iA)
                }
            })
        task.resume()              // fire off the above search query

    } // end of searchItunesFor
    
    
    func parseJSON(_ datavals: Data) -> [String: Any]?
        // Data type is a bukect of data in the a binary format
    {
        do
        {
            let json = try JSONSerialization.jsonObject(with: datavals, options:[] )
            // convert the binary Data into readable format
            if let dictionary = json as? [String: Any]
            {
//print("Got here OK - 2")
                return dictionary
            }
            else   // if nothing is returned
            {
                return nil
            }
        }
        catch let error as NSError
        {
            print(error)
            return nil
        }
    }
    // to catch an error, include in a DO block, enter the word TRY and include the catch block as above
    
    
    func archiveFriends()
        {

            for i in 0 ..< friendsArray.count  {  // remove old temperature data
                friendsArray[i].temperature = ""
                }
            
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: friendsArray)
            UserDefaults.standard.set(encodedData, forKey: "friendsArray")
        }
        
    func unarchiveFriends() -> Bool
        {
            var success = false
            
            if let friendData = UserDefaults.standard.data(forKey: "friendsArray")
            {
//                friendsArray.removeAll()
                friendsArray = (NSKeyedUnarchiver.unarchiveObject(with: friendData) as? [Friend])!
                success = true
            }
            else {
                print("No data found")
            }
            return success
        }

 //   func searchWeatherFor(_ myCoordinates: String, indexArray: Int)

    func getGeocoderData(_ givenFriendAddress: String, indexArray: Int) {
        let geocoder = CLGeocoder()
        var cityCoodinates = ""
        // produce coordinates out of address
        // reversegeocoder produce address from coordinates
        
        geocoder.geocodeAddressString(givenFriendAddress, completionHandler:
            {
                placemarks, error in
                if let geocodeError = error
                {
                    print(geocodeError.localizedDescription)
                } else {
                    if let placemark = placemarks?.first {
                        let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                        //print("\(coordinates.latitude)"+",\(coordinates.longitude)")
                        cityCoodinates = "\(coordinates.latitude)"+",\(coordinates.longitude)"
                        self.friendsArray[indexArray].coordinates = cityCoodinates
                        self.searchWeatherFor(cityCoodinates, indexArray: indexArray)
                    }
                }
        })
    }   // End of Get Coordinates from given Address function


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendsArray.count
    }
    
    func allowMultipleLines(tableViewCell:UITableViewCell) {
        tableViewCell.textLabel?.numberOfLines = 2
//        tableViewCell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        
        let citytemp = friendsArray[indexPath.row]
        var fN = ""
        if (citytemp.friendName != "") { fN = "\(citytemp.friendName)" }
        cell.textLabel?.text = fN
        var cN = ""
        var cT = ""
        if (citytemp.city != "") { cN = "\(citytemp.city)" }
        if (citytemp.temperature != "") { cT = " - Temp: \(citytemp.temperature)" }
        cell.detailTextLabel?.text = cN + cT
        let tempST = Int(citytemp.temperature)
            if tempST != nil {
        if (tempST! > 70) {
//print("Hot - \(fN) - \(cN) - \(cT)")
            cell.imageView?.image = UIImage(named: "hot")
        } else {
            if (tempST! < 50) {
//print("Cold - \(fN) - \(cN) - \(cT)")
                cell.imageView?.image = UIImage(named: "cold")
            } else {
//print("Normal - \(fN) - \(cN) - \(cT)")
                cell.imageView?.image = UIImage(named: "partly") }
        }
        }

//    self.archiveFriends() // REMOVE WHEN THIS IS SOLVED IN AppDelegate File
        return cell
    }


    var friendNameIDSague = String()
    var friendNameSague = String()
    var cityNameSague = String()
    var cityTempDeviationSague = String()
    
    override func viewWillAppear(_ animated: Bool){
        let fID = self.friendNameIDSague
        let fN = self.friendNameSague
        let cN = self.cityNameSague
        let cD = self.cityTempDeviationSague
        
        for i in 0 ..< self.friendsArray.count  {
            if fID == friendsArray[i].friendNameID {
                if fN != friendsArray[i].friendName {
                    friendsArray[i].friendName = fN
                }
                if cN != friendsArray[i].city {
                    friendsArray[i].city = cN
                    friendsArray[i].coordinates = ""
                    self.getGeocoderData(cN, indexArray: i)
                }
                if cD != friendsArray[i].deviation {
                    friendsArray[i].deviation = cD
                }
                print("new Recod: \(fID)")
                
                if fID == "new" {
                    
                    print("new Recod")
                    let date = Date()
                    let dateFormatter = DateFormatter()
                    let theDateFormat = DateFormatter.Style.full
                    let theTimeFormat = DateFormatter.Style.full
                    dateFormatter.dateStyle = theDateFormat
                    dateFormatter.timeStyle = theTimeFormat
                    let dateT = dateFormatter.string(from: date)
                    let newFriend = Friend(friendNameID: dateT, friendName: fN, city: cN, temperature: "", coordinates: "", timezone: "", alerts: "Alerts", deviation: cD)
                    friendsArray.append(newFriend)
                    self.tableView.reloadData()
                }
            }
        }
    } // end of Update Sague
    
    
    // Segue Controllers  ********************************************
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("Got up to here-4")
        if segue.identifier == "DetailViewControllerSegue"
        {
            if let destinationVC = segue.destination as? SummaryViewController {
                let path = tableView.indexPathForSelectedRow
//                let cell = tableView.cellForRow(at: path!)
                destinationVC.friendNameIDSague = String(friendsArray[(path?.row)!].friendNameID)
                destinationVC.friendNameSague = String(friendsArray[(path?.row)!].friendName)
                destinationVC.cityNameSague = String(friendsArray[(path?.row)!].city)
                destinationVC.cityTempSague = String(friendsArray[(path?.row)!].temperature)
                destinationVC.cityTempAlertsSague = String(friendsArray[(path?.row)!].alerts)
                destinationVC.cityTempDeviationSague = String(friendsArray[(path?.row)!].deviation)

            }
        }
    }    //     End of Segue Controllers  ********************************************


} //end of Class
