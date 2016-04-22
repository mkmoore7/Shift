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
import SwiftValidator

class LoginViewController: UIViewController, UITextFieldDelegate, ValidationDelegate {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    var svos :CGPoint?
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.svos = scrollView!.contentOffset;
        
        validator.registerField(emailText, errorLabel: emailErrorLabel, rules: [RequiredRule(), EmailRule(message: "Invalid email")])
        
        validator.registerField(passwordText, errorLabel: passwordErrorLabel, rules: [RequiredRule()])
    }
    
    func validationSuccessful() {
        emailErrorLabel?.hidden = true
        passwordErrorLabel?.hidden = true
        let boarderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha:1.0).CGColor
        emailText?.layer.borderColor =  boarderColor
        passwordText?.layer.borderColor =  boarderColor
        
        let loginService = LoginServices.sharedInstance
        SwiftLoader.show(title: "Loading...", animated: true)
        loginService.authenticateUser(emailText.text!, password: passwordText.text!){ error, authData in
            if error != nil {
                //self.performSegueWithIdentifier("reveal_view", sender: self)
                SwiftLoader.hide()
                SCLAlertView().showError("Login failed!", subTitle: error!.localizedDescription)
                
            } else {
                SwiftLoader.hide()
                self.performSegueWithIdentifier("reveal_view", sender: self)
            }
            
        }

    }
    
    func validationFailed(errors:[UITextField:ValidationError]) {
        for (field, error) in validator.errors {
            field.layer.borderColor = UIColor.redColor().CGColor
            field.layer.borderWidth = 1.0
            error.errorLabel?.text = error.errorMessage
            error.errorLabel?.hidden = false
        }
    }
    
    @IBAction func loginBtnTouched(sender: AnyObject) {
        textFieldDidEndEditing(emailText!)
        textFieldDidEndEditing(passwordText!)
        
        validator.validate(self)
        
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
    

}
