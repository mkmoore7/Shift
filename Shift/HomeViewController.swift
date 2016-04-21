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
    
    let tableArray:Array<String> = ["status_cell"]
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableArray[indexPath.row], forIndexPath: indexPath)
        
        return cell
    }
    
    



}

