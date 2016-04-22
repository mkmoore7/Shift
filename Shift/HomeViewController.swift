//
//  ViewController.swift
//  Shift
//
//  Created by Meredith Moore on 3/31/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import UIKit


class HomeViewController: UITableViewController {

    @IBOutlet weak var Open: UIBarButtonItem!
    
    @IBOutlet weak var label: UILabel!
    
    let tableArray:Array<String> = ["status_cell", "exercise_cell"]
    let allExercises:NSDictionary = Config.sharedInstance.getExercises()
    var exercises: Array<String> = Config.sharedInstance.getExercises().allKeys as! Array<String>
    let videos:Array<String> = ["yi01KXc7laY", "eW0xZApmUyo"]
    
    var varView = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       if self.revealViewController() != nil { 
          Open.target = self.revealViewController()
          Open.action = #selector(SWRevealViewController.revealToggle(_:))
          self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        
        return exercises.count
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            let usename = LoginServices.sharedInstance.username()
            return "Welcome \(usename)!"
        }
        return "Excercises for today"
    }
    
    
    override func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell
    {
        
        let id = (indexPath.section == 0) ? self.tableArray[0] : self.tableArray[1]
        let cell = tableView.dequeueReusableCellWithIdentifier(id, forIndexPath: indexPath)
        
        if (indexPath.section > 0) {
            let ex: String = self.exercises[indexPath.row]
            (cell as! ExerciseCellView).nameSetup(ex)
            (cell as! ExerciseCellView).videoSetup((self.allExercises[ex] as! NSDictionary).valueForKey("video") as! String)
            
            let view = UIView(frame: CGRectMake(0, 0, cell.contentView.frame.size.width, 20))
            
            view.backgroundColor = UIColor.clearColor()
            cell.contentView.addSubview(view)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section > 0){
            return 267
        }
        
        return tableView.rowHeight
    }
    
    
    



}

