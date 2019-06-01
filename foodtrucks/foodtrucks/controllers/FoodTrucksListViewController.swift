//
//  FoodTrucksListViewController.swift
//  foodtrucks
//
//  Created by darshan on 5/31/19.
//  Copyright © 2019 darshan. All rights reserved.
//

import UIKit

class FoodTrucksListViewController: UITableViewController {

    var foodTrucksInfo : Array<FoodTrucks> = []
    func completionHandler(success: Bool, jsonString: String) {
        if(!success) {
            // don't load the table views
            // error getting data, show it to the user
        } else {
            let jsonData = jsonString.data(using: .utf8)!
            let decoder = JSONDecoder()
            do {
                foodTrucksInfo = try decoder.decode(Array<FoodTrucks>.self, from: jsonData)
                print("before size ",foodTrucksInfo.count)
                fetchOpenFoodTrucks()
                DispatchQueue.main.async { [weak self] in
                    if((self?.foodTrucksInfo.count)! > 0) {
                        self?.tableView.reloadData()
                    }
                }
            } catch let error {
                print(error)
            }
            print("after size ",foodTrucksInfo.count)
        }
    }
    
    func fetchFormattedHourAndMinute(time : String) -> Date {
        let timeArray = time.components(separatedBy: ":")
        let calendar = Calendar.current
        let now = Date()
        let formattedTime = calendar.date(
            bySettingHour: timeArray.count > 0 ? Int(timeArray[0]) ?? 0 : 0,
            minute: timeArray.count > 1 ? Int(timeArray[1]) ?? 0 : 0,
            second: 0,
            of: now) ?? now
        return formattedTime
    }
    
    func fetchOpenFoodTrucks() {
        var filteredFoodTrucksInfo : Array<FoodTrucks> = []
        for foodtruck in foodTrucksInfo {
            let now = Date()
            let startTime = fetchFormattedHourAndMinute(time: foodtruck.trucks[0].start24 ?? "00:00")
            let endTime = fetchFormattedHourAndMinute(time: foodtruck.trucks[0].end24 ?? "00:00")
            if now >= startTime &&
                now <= endTime
            {
                filteredFoodTrucksInfo.append(foodtruck)
            }
        }
        foodTrucksInfo = filteredFoodTrucksInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFoodTruckList()
    }

    func fetchFoodTruckList() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        let url = "https://data.sfgov.org/resource/jjew-r69b.json?dayofweekstr=" + dayInWeek
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        DispatchQueue.global(qos: .background).async {
            Network.downloadUrl(url: URL(string: url)!, completion: self.completionHandler(success:jsonString:))
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodTrucksInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FoodTruckTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FoodTruckTableViewCell", for: indexPath) as! FoodTruckTableViewCell
        let truckInfo = foodTrucksInfo[indexPath.row]
        cell.name.text = truckInfo.trucks[0].applicant
        cell.address.text = truckInfo.trucks[0].location
        cell.openHours.text = (truckInfo.trucks[0].starttime ?? "-- AM") + "-" + (truckInfo.trucks[0].endtime ?? "-- PM")
        cell.optionalText.text = truckInfo.trucks[0].optionaltext ?? ""
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
