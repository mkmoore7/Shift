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
    let execises:Array<String> = [ "Cloack Reach", "Walk"]
    let videos:Array<String> = ["yi01KXc7laY", "yi01KXc7laY"]
    
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
        
        return 2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return ""
        }
        return "Excercises for today"
    }
    
    
    override func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell
    {
        
        let id = (indexPath.section == 0) ? self.tableArray[0] : self.tableArray[1]
        let cell = tableView.dequeueReusableCellWithIdentifier(id, forIndexPath: indexPath)
        
        if (indexPath.section > 0) {
            (cell as! ExerciseCellView).nameSetup(self.execises[indexPath.row])
            (cell as! ExerciseCellView).videoSetup(self.videos[indexPath.row])
            
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
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    



}

