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
        let dayorder : String?
        let dayofweekstr : String?
        let starttime : String?
        let endtime : String?
        let start24 : String?
        let end24 : String?
        let latitude : String?
        let longitude : String?
        let applicant : String?
        let location : String?
        let optionaltext : String?
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        trucks = [try container.decode(Information.self)]
    }
}
