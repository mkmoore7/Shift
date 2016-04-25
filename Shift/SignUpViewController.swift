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

class SignUpViewController: UIViewController, UITextFieldDelegate, ValidationDelegate {
    
    
    @IBOutlet weak var emailText: MFTextField!
    @IBOutlet weak var firstNameText: MFTextField!
    @IBOutlet weak var secondNameText: MFTextField!
    @IBOutlet weak var passwordText: MFTextField!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var passwordRepeatText: MFTextField!

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    var svos :CGPoint?
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.svos = scrollView!.contentOffset;
        
        firstNameText!.autocapitalizationType = .Words
        
        secondNameText!.autocapitalizationType = .Words
        
        backBtn!.layer.borderWidth = 1.0
        backBtn!.layer.borderColor = Constants.ui.complimentaryBGColor.CGColor
        backBtn!.layer.cornerRadius = 5.0
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action:#selector(self.doneButtonPressed(_:)))
        
    
        validator.registerField(emailText, rules: [RequiredRule(), EmailRule(message: "Invalid email")])
        validator.registerField(firstNameText, rules: [RequiredRule()])
        validator.registerField(secondNameText, rules: [RequiredRule()])
        
        validator.registerField(passwordText, rules: [RequiredRule()])
        validator.registerField(passwordRepeatText, rules: [RequiredRule(), ConfirmationRule(confirmField: passwordText, message: "Passwords must match")])
    }
    
    @IBAction func doneButtonPressed(sender:AnyObject){
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func validationSuccessful() {
        emailText?.setError(nil, animated: true)
        firstNameText?.setError(nil, animated: true)
        secondNameText?.setError(nil, animated: true)
        passwordText?.setError(nil, animated: true)
        passwordRepeatText?.setError(nil, animated: true)
        
        
        let loginService = LoginServices.sharedInstance
        SwiftLoader.show(title: "Loading...", animated: true)
        
        loginService.createUser((emailText?.text!)!, password: (passwordText?.text!)!, firstName: (firstNameText?.text!)!, lastName: (secondNameText?.text!)!) { error, authData in
            if error != nil {
                SwiftLoader.hide()
                SCLAlertView().showError("Sign up failed!", subTitle: error!.localizedDescription)
            
            } else {
            SwiftLoader.hide()
                self.performSegueWithIdentifier("reveal_view_signup", sender: self)
            }
        }
        
    }
    
    func validationFailed(errors:[UITextField:ValidationError]) {
        for (field, error) in validator.errors {
            let f : MFTextField = field as! MFTextField
            f.setError(self.errorWithLocalizedDescription(error.errorMessage), animated: true)
        }
    }
    
    @IBAction func signUpBtnTouched(sender: AnyObject) {
        textFieldDidEndEditing(emailText!)
        textFieldDidEndEditing(firstNameText!)
        textFieldDidEndEditing(secondNameText!)
        textFieldDidEndEditing(passwordText!)
        textFieldDidEndEditing(passwordRepeatText!)
        
        validator.validate(self)
        
    }
    
    func errorWithLocalizedDescription(localizedDescription: String) -> NSError{
        let userInfo = [NSLocalizedDescriptionKey: localizedDescription]
        return  NSError(domain: "ShiftSignUp", code: 1, userInfo: userInfo)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == self.passwordRepeatText!) {
            self.passwordText!.resignFirstResponder()
            self.signUpBtn!.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        } else if (textField == self.emailText!) {
            self.firstNameText!.becomeFirstResponder();
        } else if (textField == self.firstNameText!) {
            self.secondNameText!.becomeFirstResponder();
        } else if (textField == self.secondNameText!) {
            self.passwordText!.becomeFirstResponder();
        } else if (textField == self.passwordText!) {
            self.passwordRepeatText!.becomeFirstResponder();
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
