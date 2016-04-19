//
//  LoginServices.swift
//  Shift
//
//  Created by Scaria on 4/19/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation
import Firebase
import SCLAlertView

class LoginServices: NSObject{
    var firebaseRef:Firebase;
    let firebaseUrl: NSString;
    let firebaseSecret: NSString;
    var authData:FAuthData?
    static let sharedInstance = LoginServices(firebaseUrl: Constants.FireBase.firebaseUrl, secret: Constants.FireBase.firebaseSecret)
    
        
    
    private init(firebaseUrl:String, secret: String){
        self.firebaseUrl = firebaseUrl;
        self.firebaseSecret = secret;
        self.firebaseRef = Firebase(url:self.firebaseUrl as String);
        self.authData = nil
    }
    
    func createUser(email:String, password:String, onCompletion:(NSError?, NSObject?)->()){
        self.firebaseRef.createUser(email, password: password,
            withValueCompletionBlock: { error, authData in
               if error != nil {
                onCompletion(error, nil)
                //SCLAlertView().showInfo("Important info ", subTitle: "\(error)")
                  
               } else {
                onCompletion(nil, authData)
                   //SCLAlertView().showSuccess("Registered!", subTitle: "Successfully created user account.")
               }
        })
    }
    
    func authenticateUser(email:String, password:String, onCompletion:(NSError?, FAuthData?)->()){
        self.firebaseRef.authUser(email, password: password,
             withCompletionBlock: { error, authData in
                 if error != nil {
                    self.authData = nil
                    onCompletion(error, nil)
                     
                 } else {
                    self.authData = authData;
                    onCompletion(nil, authData)
                 }
        })
    }
    
    func logout(){
        self.firebaseRef.unauth()
        self.authData = nil
    }
    
    
    
    func setValue(value: NSObject){
        self.firebaseRef.setValue(value)
    }
    
}
