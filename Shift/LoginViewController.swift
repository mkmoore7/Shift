//
//  LoginViewController.swift
//  Shift
//
//  Created by Scaria on 4/19/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation
import SCLAlertView

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBAction func loginBtn(sender: AnyObject) {
        let loginService = LoginServices.sharedInstance
        loginService.authenticateUser(emailText.text!, password: passwordText.text!){ error, authData in
                if error != nil {
                    SCLAlertView().showError("Login failed!", subTitle: error!.localizedDescription)
                    
                } else {
                    self.performSegueWithIdentifier("reveal_view", sender: self)
                }
            
            }
        
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    

}
