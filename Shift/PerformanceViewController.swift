//
//  PerformanceBiewController.swift
//  Shift
//
//  Created by Scaria on 4/20/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation

class PerformanceViewController: UIViewController{
    
    
    @IBOutlet weak var navigationMenu: UIBarButtonItem!

    override func viewDidLoad() {
        if self.revealViewController() != nil {
            navigationMenu.target = self.revealViewController()
            navigationMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }
}