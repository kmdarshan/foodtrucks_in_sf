//
//  NetworkHandlers.swift
//  foodtrucks
//
//  Created by darshan on 5/27/19.
//  Copyright © 2019 darshan. All rights reserved.
//

import Foundation

class Network {
    class func downloadUrl(url : URL, completion: @escaping (Bool, String) -> ()) {
        let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
            if let localURL = localURL {
                guard let string = try? String(contentsOf: localURL) , error == nil else {
                    completion(false, error?.localizedDescription ?? "No data")
                    return
                }
                completion(true, string)
            }
        }
        task.resume()
    }
}
