//
//  ViewController.swift
//  foodtrucks
//
//  Created by darshan on 5/25/19.
//  Copyright © 2019 darshan. All rights reserved.
//

import UIKit

class MainAppController: UINavigationController {
    
    func completionHandler(success: Bool, jsonString: String) {
        if(!success) {
            // don't load the table views
        } else {
            let jsonData = jsonString.data(using: .utf8)
            let decoder = JSONDecoder()
//            let foodtruckInfo = try! decoder.decode(Array<FoodTrucks>.self, from: jsonData!)
//            print("size ",foodtruckInfo.count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Network.downloadUrl(url: URL(string: "https://data.sfgov.org/resource/jjew-r69b.json")!, completion: completionHandler(success:jsonString:))
    }
    
//    func downloadUrl() {
//        let url = URL(string: "https://data.sfgov.org/resource/jjew-r69b.json")!
//
//        let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
//            if let localURL = localURL {
//                guard let string = try? String(contentsOf: localURL) , error == nil else {
//                    print(error?.localizedDescription ?? "No data")
//                    return
//                }
//                let jsonData = string.data(using: .utf8)
//                let decoder = JSONDecoder()
//                let foodtruckInfo = try! decoder.decode(Array<FoodTrucks>.self, from: jsonData!)
//                print("size ",foodtruckInfo.count)
//            }
//        }
//        task.resume()
//    }
}

