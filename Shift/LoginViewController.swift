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
import MaterialTextField

class LoginViewController: UIViewController, UITextFieldDelegate, ValidationDelegate {
    
    
    @IBOutlet weak var emailText: MFTextField!
    @IBOutlet weak var passwordText: MFTextField!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var loginBtn: UIButton!
    var svos :CGPoint?
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.svos = scrollView!.contentOffset;
        
        validator.registerField(emailText, rules: [RequiredRule(), EmailRule(message: "Invalid email")])
        
        validator.registerField(passwordText, rules: [RequiredRule()])
    }
    
    func validationSuccessful() {
        emailText?.setError(nil, animated: true)
        passwordText?.setError(nil, animated: true)
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
            let f : MFTextField = field as! MFTextField
            f.setError(self.errorWithLocalizedDescription(error.errorMessage), animated: true)
        }
    }
    
    @IBAction func loginBtnTouched(sender: AnyObject) {
        textFieldDidEndEditing(emailText!)
        textFieldDidEndEditing(passwordText!)
        
        validator.validate(self)
        
    }
    
    func errorWithLocalizedDescription(localizedDescription: String) -> NSError{
        let userInfo = [NSLocalizedDescriptionKey: localizedDescription]
        return  NSError(domain: "ShiftLogin", code: 1, userInfo: userInfo)
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
