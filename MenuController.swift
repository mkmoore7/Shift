//
//  BackTableVC.swift
//  Shift
//
//  Created by Meredith Moore on 3/31/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation

class MenuController: UITableViewController {
    
    var tableArray : Array<String> = Config.sharedInstance.menuItems
    
    override func viewDidLoad() {
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
    
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    
    override func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = tableArray[indexPath.row]
        cell.textLabel?.font = UIFont.boldSystemFontOfSize(cell.textLabel!.font.pointSize)
        cell.textLabel?.adjustsFontSizeToFitWidth
        
        cell.imageView?.image = Config.sharedInstance.menuIcons.valueForKey(tableArray[indexPath.row]) as? UIImage
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "logout"){
            LoginServices.sharedInstance.logout()
        }
    }
    
    
}