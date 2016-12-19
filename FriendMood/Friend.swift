//
//  FriendsDataModel.swift
//  FriendMood
//
//  Created by Marco Almeida on 12/14/16.
//  Copyright © 2016 THE IRON YARD. All rights reserved.
//

import Foundation


struct CityTemps
{
    var friendNameID: String
    var friendName: String
    var city: String
    var temperature: String
    var coordinates: String
    var timezone: String
//    var latitude: String
//    var longitude: String
    var alerts: String
    var deviation: String
    
    static func citiesWithJSON(_ dictionary: [String: Any]) -> [CityTemps]
    {
        var aCityTemp = [CityTemps]()    // initialize an empty Array
        if dictionary.count > 0
        {
            if let timezoneT = dictionary["timezone"] as? String
            {
                let currently = dictionary["currently"] as! [String: Any]
                let temperatureT = currently["temperature"] as! Int
                let pt = String(temperatureT)
                let alertsT = "Not implemented yet. Need to review API Documentation and learn how to capture this data accordingly"
                let latitudeT = dictionary["latitude"] as! Int
                let longitudeT = dictionary["longitude"] as! Int
                let lat = String(latitudeT)
                let lon = String(longitudeT)
                let cc =  "\(lat),\(lon)"
                let anCity = CityTemps(friendNameID: "", friendName: "", city: "", temperature: pt, coordinates: cc, timezone: timezoneT, alerts: alertsT, deviation: "")
                aCityTemp.append(anCity)
// print(pt )
// print("Got here Temp: \(pt) - 4")
            }
        }
        return aCityTemp
    }
}


class Friend: NSObject, NSCoding
{
    var friendNameID: String
    var friendName: String
    var city: String
    var temperature: String
    var coordinates: String
    var timezone: String
    var alerts: String
    var deviation: String
    
    
    //    static func citiesWithJSON(_ dictionary: [String: Any]) -> [CityTemps]
    //    {
    
    
    required init(friendNameID: String, friendName: String, city: String, temperature: String, coordinates: String, timezone: String, alerts: String, deviation: String)
    {
        self.friendNameID = friendNameID
        self.friendName = friendName
        self.city = city
        self.temperature = temperature
        self.coordinates = coordinates
        self.timezone = timezone
        self.alerts = alerts
        self.deviation = deviation
    }
    
    required init(coder decoder: NSCoder) {
        self.friendNameID = decoder.decodeObject(forKey: "friendNameID") as? String ?? ""
        self.friendName = decoder.decodeObject(forKey: "friendName") as? String ?? ""
        self.city = decoder.decodeObject(forKey: "city") as? String ?? ""
        self.temperature = decoder.decodeObject(forKey: "temperature") as? String ?? ""
        self.coordinates = decoder.decodeObject(forKey: "coordinates") as? String ?? ""
        self.timezone = decoder.decodeObject(forKey: "timezone") as? String ?? ""
        self.alerts = decoder.decodeObject(forKey: "alerts") as? String ?? ""
        self.deviation = decoder.decodeObject(forKey: "deviation") as? String ?? ""
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(friendNameID, forKey: "friendNameID")
        aCoder.encode(friendName, forKey: "friendName")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(temperature, forKey: "temperature")
        aCoder.encode(coordinates, forKey: "coordinates")
        aCoder.encode(timezone, forKey: "timezone")
        aCoder.encode(alerts, forKey: "alerts")
        aCoder.encode(deviation, forKey: "deviation")
    }
    
}



/*
 
 API Documentation:
 https://darksky.net/dev/docs/forecast
 
 Mandatory Parameters:
 Sample Request: https://api.darksky.net/forecast/[key]/[latitude],[longitude]
 
 Optional Parameters as a Quary String:
 A typical URL containing a query string is as follows:
 http://example.com/over/there?name=ferret
 

 
 "alerts": [
 {
 "title": "Flood Watch for Mason, WA",
 "time": 1453375020,
 "expires": 1453407300,
 "description":
 
 
 {
 
 "latitude": 47.20296790272209,
 "longitude": -123.41670367098749,
 "timezone": "America/Los_Angeles",
 "currently": {
 "time": 1453402675,
 "summary": "Rain",
 "icon": "rain",
 "precipIntensity": 0.1685,
 "precipIntensityError": 0.0067,
 "precipProbability": 1,
 "precipType": "rain",
 "temperature": 48.71,
 },
 "daily": {
 "summary": "Light rain throughout the week", "icon": "rain",
 "data": [
 {
 "time": 1453363200,
 "summary": "Rain throughout the day.",
 "precipIntensity": 0.1134,
 "precipProbability": 0.87,
 "precipType": "rain",
 "temperatureMin": 41.42,
 "temperatureMax": 53.27,
 },
 ... ]
 }
 "alerts": [
 {
 "title": "Flood Watch for Mason, WA",
 "time": 1453375020,
 ],
 {
 
 
 */







