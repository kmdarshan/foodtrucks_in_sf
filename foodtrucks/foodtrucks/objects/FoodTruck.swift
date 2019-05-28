//
//  FoodTrucks.swift
//  foodtrucks
//
//  Created by darshan on 5/25/19.
//  Copyright © 2019 darshan. All rights reserved.
//

import Foundation

struct FoodTrucks : Decodable {
    var trucks : [Information]
    struct Information : Decodable {
        var dayorder : String
        var dayofweekstr : String
        var starttime : String
        var endtime : String
        var start24 : String
        var end24 : String
        var latitude : String
        var longitude : String
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        trucks = [try container.decode(Information.self)]
    }
}
