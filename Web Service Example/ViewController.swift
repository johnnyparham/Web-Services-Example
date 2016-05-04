//
//  ViewController.swift
//  Web Service Example
//
//  Created by Johnny Parham on 4/20/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import UIKit
  

class ViewController: UIViewController {

    
    
    @IBOutlet weak var cityNameTextField: UITextView!
    @IBOutlet weak var getDataButton: UIButton!
    
    @IBOutlet weak var tempNightLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!

    @IBAction func getDataButtonClicked(sender:AnyObject) {
        
        let getData = AFHTTPSessionManager()
        
        let url = "http://api.openweathermap.org/data/2.5/forecast/daily?q=\(cityNameTextField.text)&mode=json&units=imperial&cnt=1&appid=b9bbdea26355fa342a0d52530f0bb7c1"
        
        
        getData .GET(url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!, parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask,responseObject: AnyObject?) in
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
                
                
                
                
                
            }
            
            
            
            
            
            }, failure: { (operation: NSURLSessionDataTask?,error: NSError) in
                print("Error: " + error.localizedDescription)
        })
        
    }
    
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
                            
                            
                            activityIndicatorView.removeFromSuperview()
                                            

                        }
                        
        
        
      
       
    },
                     failure: { (operation: NSURLSessionDataTask?,error: NSError) in
                        print("Error: " + error.localizedDescription)
        })
    }
    
    

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fixTempForDisplay(temp: Double) -> String {
        
        let tempString = String(format: "%.1f", temp)
        return tempString
    }
    
    func apiSuccess(operation: NSURLSessionDataTask,responseObject: AnyObject?) {
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
        
    }
    
   
    }

}

