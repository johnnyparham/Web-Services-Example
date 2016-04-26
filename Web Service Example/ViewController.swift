//
//  ViewController.swift
//  Web Service Example
//
//  Created by Johnny Parham on 4/20/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import UIKit
  

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.forecastLabel.text = ""
        //instantiate a gray Activity Indicator View
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        //add the activity to the viewController's view
        view.addSubview(activityIndicatorView)
        //position the Activity Indicator View in the center of the view
        activityIndicatorView.center = view.center
        //tell the Activity Indicator View to begin animating
        activityIndicatorView.startAnimating()
        
        let manager = AFHTTPSessionManager()
        manager .GET("http://api.openweathermap.org/data/2.5/forecast/daily?q=NewYork&mode=json&units=imperial&cnt=1&appid=b9bbdea26355fa342a0d52530f0bb7c1",
                     parameters: nil,
                     progress: nil,
                     success: { (operation: NSURLSessionDataTask,responseObject: AnyObject?) in
                        if let responseObject = responseObject {
                            print("Returned: " + responseObject.description)
                            let json = JSON(responseObject)
                            
                            //Get conditions
                            if let forecast = json["list"][0]["weather"][0]["description"].string {
                                self.forecastLabel.text = forecast
                            }
                            //Get city locations
                            if let location = json["city"]["name"].string {
                                self.cityName.text = location
                            }
                            //Get high temp
                            if let dayWeather = json["list"][0]["temp"]["max"].double {
                                self.tempLabel.text = "\(self.fixTempForDisplay(dayWeather))"
                            }
                            //Get low temp
                            if let nightWeather = json["list"][0]["temp"]["min"].double {
                                self.tempNightLabel.text = "\(self.fixTempForDisplay(nightWeather))"
                            }
                            
                            
                            
                            
//                        if let listOfDays = responseObject!["list"] as? NSArray {
//                            if let tomorrow = listOfDays[0] as? NSDictionary {
//                                if let tomorrowsWeather = tomorrow["weather"] as? NSArray {
//                                    if let firstWeatherOfDay = tomorrowsWeather[0] as? NSDictionary {
//                                        if let forecast = firstWeatherOfDay["description"] as? String {
                            
                            activityIndicatorView.removeFromSuperview()
                                            
 //                                             }
 //                                    }
 //                                }
 //                           }
                        }
                        
        
        
      
       
    },
                     failure: { (operation: NSURLSessionDataTask?,error: NSError) in
                        print("Error: " + error.localizedDescription)
        })
    }
    

   
    @IBOutlet weak var tempNightLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fixTempForDisplay(temp: Double) -> String {
        
        let tempString = String(format: "%.0f", temp)
        return tempString
    }


}

