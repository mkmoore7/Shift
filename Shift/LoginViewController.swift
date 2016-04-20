//
//  LoginViewController.swift
//  Shift
//
//  Created by Scaria on 4/19/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation
import SCLAlertView

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    var svos :CGPoint?
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        svos = scrollView!.contentOffset;
        var rc:CGRect = textField.bounds;
        rc = textField.convertRect(rc, toView: scrollView);
        var pt = rc.origin;
        pt.x = 0;
        pt.y =  pt.y - (UIScreen.mainScreen().bounds.height/4.0);
        scrollView.setContentOffset(pt, animated: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        scrollView.setContentOffset(svos!, animated: true)
        textField.resignFirstResponder()
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    

}
