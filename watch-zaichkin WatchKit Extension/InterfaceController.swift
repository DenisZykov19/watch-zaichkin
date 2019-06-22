//
//  InterfaceController.swift
//  watch-zaichkin WatchKit Extension
//
//  Created by WSR on 6/22/19.
//  Copyright © 2019 WSR. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire
import SwiftyJSON


class InterfaceController: WKInterfaceController {

    var city = "Moscow"
    @IBOutlet weak var CityName: WKInterfaceLabel!
    @IBOutlet weak var TempLabel: WKInterfaceLabel!
    @IBOutlet weak var WeatherImage: WKInterfaceImage!
    
    func loadCurrentTemp() {
        let apiKey = "1e936ee21707e2a418e98dca00877357"
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&apiKey=\(apiKey)&units=metric"
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                //если запрос выполнен успешно, то разбираем ответ и вытаскиваем нужные данные
                let json = JSON(value)
                print("JSON: \(json)")
                self.TempLabel.setText(json["main"]["temp"].stringValue + " °C")
                
                let icon = json["weather"][0]["icon"].stringValue
                let imageStr = "http://openweathermap.org/img/w/" + icon + ".png"
                let imageUrl = URL(string: imageStr)
                if let data = try? Data(contentsOf: imageUrl!) {
                    self.WeatherImage.setImage(UIImage(data: data))
                }
                
            case .failure(let error):
                print(error)

            }
    }
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        loadCurrentTemp()
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

