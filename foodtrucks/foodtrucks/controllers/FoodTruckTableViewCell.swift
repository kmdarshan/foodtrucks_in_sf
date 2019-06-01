//
//  FoodTruckTableViewCell.swift
//  foodtrucks
//
//  Created by darshan on 5/31/19.
//  Copyright © 2019 darshan. All rights reserved.
//

import UIKit

class FoodTruckTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var optionalText: UILabel!
    @IBOutlet weak var openHours: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
