//
//  LoginViewController.swift
//  Shift
//
//  Created by Scaria on 4/19/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation
import SCLAlertView
import SwiftLoader

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var loginBtn: UIButton!
    var svos :CGPoint?
    
    override func viewDidLoad() {
        self.svos = scrollView!.contentOffset;
    }
    
    @IBAction func loginBtnTouched(sender: AnyObject) {
        textFieldDidEndEditing(emailText!)
        textFieldDidEndEditing(passwordText!)
        
        let loginService = LoginServices.sharedInstance
        SwiftLoader.show(title: "Loading...", animated: true)
        loginService.authenticateUser(emailText.text!, password: passwordText.text!){ error, authData in
                if error != nil {
                    self.performSegueWithIdentifier("reveal_view", sender: self)
                    SwiftLoader.hide()
                    SCLAlertView().showError("Login failed!", subTitle: error!.localizedDescription)
                    
                } else {
                    SwiftLoader.hide()
                    self.performSegueWithIdentifier("reveal_view", sender: self)
                }
            
            }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == self.passwordText!) {
            self.passwordText!.resignFirstResponder()
            self.loginBtn!.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        } else if (textField == self.emailText!) {
            self.passwordText!.becomeFirstResponder();
        }
        return true;
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        var rc:CGRect = textField.bounds;
        rc = textField.convertRect(rc, toView: scrollView!);
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
