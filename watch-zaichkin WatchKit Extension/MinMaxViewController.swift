//
//  MinMaxViewController.swift
//  watch-zaichkin
//
//  Created by WSR on 6/22/19.
//  Copyright © 2019 WSR. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire
import SwiftyJSON


class MinMaxViewController: WKInterfaceController {
    let city = "Moscow"
    @IBOutlet weak var Max: WKInterfaceLabel!
    @IBOutlet weak var Min: WKInterfaceLabel!

    override func willActivate() {
        loadCurrentTemp()
        super.willActivate()
        // Do any additional setup after loading the view.
    }
    
    override func didDeactivate() {

        super.didDeactivate()
        // Do any additional setup after loading the view.
    }
    func loadCurrentTemp(){
    
    let apiKey = "1e936ee21707e2a418e98dca00877357"
    let url = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&apiKey=\(apiKey)&units=metric"
    Alamofire.request(url, method: .get).validate().responseJSON { response in
    switch response.result {
    case .success(let value):
    //если запрос выполнен успешно, то разбираем ответ и вытаскиваем нужные данные
    let json = JSON(value)
    print("JSON: \(json)")
    
    self.Min.setText("Min: " + json["main"]["temp_min"].stringValue + " °C")
    self.Max.setText("Max: " + json["main"]["temp_miax"].stringValue + " °C")
    
    
    case .failure(let error):
    print(error)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
        }
}
}
