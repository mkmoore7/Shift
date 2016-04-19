//
//  SettingsVC.swift
//  Shift
//
//  Created by Meredith Moore on 4/19/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation

class SettingsVC: UITableViewController{
    
    var TableArray = [String]()
    
    override func viewDidLoad() {
        
        TableArray = ["Home","Accelerometer", "Notifcations","Vibration", "Sound"]
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    
    override func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        return cell
    }
    
}