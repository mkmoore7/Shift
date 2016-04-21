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
    
    struct User{
        var firstname:String
        var lastname:String
        var lastLogin: NSDate
        
        init(){
            firstname = ""
            lastname = ""
            lastLogin = NSDate.init()
        }
    }
    
    var firebaseRef:Firebase;
    let firebaseUrl: NSString;
    let firebaseSecret: NSString;
    var authData:FAuthData?
    var user:User;
    static let sharedInstance = LoginServices(firebaseUrl: Constants.FireBase.firebaseUrl, secret: Constants.FireBase.firebaseSecret)
    
        
    
    private init(firebaseUrl:String, secret: String){
        Firebase.defaultConfig().persistenceEnabled = true
        self.firebaseUrl = firebaseUrl;
        self.firebaseSecret = secret;
        self.firebaseRef = Firebase(url:self.firebaseUrl as String);
        self.authData = nil
        self.user = User()
        debugPrint(user)
    }
    
    func createUser(email:String, password:String, onCompletion:(NSError?, NSObject?)->()){
        self.firebaseRef.createUser(email, password: password,
            withValueCompletionBlock: { error, authData in
               if error != nil {
                onCompletion(error, nil)
                  
               } else {
                self.recordNewUser(email, firstname: "Apple", lastname: "Dump")
                self.recordLogin(email)
                onCompletion(nil, authData)
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
                    self.getUserDetails()
                    self.recordLogin(email)
                    onCompletion(nil, authData)
                 }
        })
    }
    
    func getUserDetails(){
        if(self.authData == nil){
            return
        }
        let key = self.encodeString(self.email())
        let users = self.firebaseRef.childByAppendingPath("/users/\(key)/")
        
        users.observeEventType(FEventType.Value, withBlock: {dataSnapShot in
            if(dataSnapShot.value != nil){
                self.user.firstname = dataSnapShot!.value!["firstname"]! as! String
                self.user.lastname = dataSnapShot!.value!["lastname"]! as! String
            }
        
        })
    }
    
    func username()-> String{
        if(self.user.firstname != ""){
            return "\(self.user.firstname) \(self.user.lastname)"
        }
        return self.email()
    }
    
    func email() -> String{
        if(self.authData == nil){
            return "InvalidUser"
        }
        return self.authData!.providerData["email"] as! String
    }
    
    func profilePicUrl() -> String{
        if(self.authData == nil){
            return ""
        }
        return self.authData!.providerData["profileImageURL"] as! String
    }
    
    func encodeString(string: String) -> String{
        let customAllowedSet =  NSCharacterSet(charactersInString:".$[]/").invertedSet
        return string.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
    }
    
    func recordNewUser(email: String, firstname:String, lastname:String){
        let key = self.encodeString(email)
        let userData = [
            "firstname" : firstname,
            "lastname": lastname
        ]
        let users = self.firebaseRef.childByAppendingPath("/users/")
        let user = users.childByAppendingPath("/\(key)/")
        user.setValue(userData, withCompletionBlock: { error, fireBaseRef in
            if error != nil{
                debugPrint("User creation write failed : \(email)");
            }else{
                debugPrint("User creation write success : \(email)");
            }
        })

    
    }
    
    
    func recordLogin(email: String){
        
        let timeInterval = NSDate().timeIntervalSince1970
        let key = self.encodeString(email)
        let user = self.firebaseRef.childByAppendingPath("/logins/\(key)/")
        
        let login = user.childByAutoId()
        login.setValue(timeInterval, withCompletionBlock: { error, fireBaseRef in
            if error != nil{
                debugPrint("Login write failed : \(email) : \(timeInterval)");
            }else{
                debugPrint("Login write success : \(email) : \(timeInterval)");
            }
        })
        self.getLastLogin()
    }
    
    func getLastLogin(){
        if(self.authData == nil){
            return
        }
        let key = self.encodeString(self.email())
        let logins = self.firebaseRef.childByAppendingPath("/logins/\(key)/")
        
        logins.queryLimitedToLast(1).observeEventType(FEventType.Value, withBlock:{ snapShot in
            if (snapShot!.value != nil){
                self.user.lastLogin = NSDate(timeIntervalSince1970: snapShot!.value!.allValues![0] as! NSTimeInterval)
            }
        })
    
    }
    
    func lastLogin()-> NSDate{
        return self.user.lastLogin
    }
    
    func logout(){
        self.firebaseRef.unauth()
        self.authData = nil
    }
    
    
    func setValue(value: NSObject){
        self.firebaseRef.setValue(value)
    }
    
}
