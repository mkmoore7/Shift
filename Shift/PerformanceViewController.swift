//
//  PerformanceBiewController.swift
//  Shift
//
//  Created by Scaria on 4/20/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation
import Charts

class PerformanceViewController: UITableViewController{
    
    
    @IBOutlet weak var navigationMenu: UIBarButtonItem!
    let exercises:Array<String> = Config.sharedInstance.getExercises().exercises
    let videos:Array<String> = Config.sharedInstance.getExercises().videos

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            navigationMenu.target = self.revealViewController()
            navigationMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return exercises.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return exercises[section]
    }
    
    
    override func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell{
        
        let id = "performance-chart-cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(id, forIndexPath: indexPath)
        
//        if (indexPath.section > 0) {
//            let ex: String = self.exercises[indexPath.row]
//            (cell as! ExerciseCellView).nameSetup(ex)
//            (cell as! ExerciseCellView).videoSetup(self.videos[indexPath.row])
//            
//            let view = UIView(frame: CGRectMake(0, 0, cell.contentView.frame.size.width, 20))
//            
//            view.backgroundColor = UIColor.clearColor()
//            cell.contentView.addSubview(view)
//        }
        
        return cell
    }
    

}