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
        
        let manager = AFHTTPSessionManager()
        manager .GET("http://api.openweathermap.org/data/2.5/forecast/daily?q=London&mode=json&units=metric&cnt=1&appid=b9bbdea26355fa342a0d52530f0bb7c1",
                     parameters: nil,
                     progress: nil,
                     success: { (operation: NSURLSessionDataTask,responseObject: AnyObject?) in
                        if let listOfDays = responseObject!["list"] as? NSArray {
                            if let tomorrow = listOfDays[0] as? NSDictionary {
                                if let tomorrowsWeather = tomorrow["weather"] as? NSArray {
                                    if let firstWeatherOfDay = tomorrowsWeather[0] as? NSDictionary {
                                        if let forecast = firstWeatherOfDay["description"] as? String {
                                            self.forecastLabel.text = forecast
                                        }
                                    }
                                }
                            }
                        }
                        
        
        
      
       
    },
                     failure: { (operation: NSURLSessionDataTask?,error: NSError) in
                        print("Error: " + error.localizedDescription)
        })
    }
    
    @IBOutlet weak var forecastLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

