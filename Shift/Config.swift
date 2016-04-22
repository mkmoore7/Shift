//
//  Config.swift
//  Shift
//
//  Created by Scaria on 4/20/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation
import SwiftLoader
import ionicons

class Config: NSObject {
    
    static let sharedInstance = Config()
    var config : SwiftLoader.Config;
    var menuIcons: NSDictionary;
    let menuItems = ["Home","Exercises","Performance", "Settings", "Logout"]
    let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    let allExercises:NSDictionary = [
        "Clock Reach": [
            "enabled": "true",
            "video": "yi01KXc7laY"],
        "Side Hip Raise":[
            "enabled": "true",
            "video": "eW0xZApmUyo"]
    ]
    
    private override init(){
        self.config =  SwiftLoader.Config();
        self.menuIcons = [:]
        
        if(defaults.dictionaryForKey("exercises") == nil){
        defaults.setObject(allExercises, forKey: "exercises")
        }
    }
    
    func getExercises() -> (NSDictionary){
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let exercises = defaults.dictionaryForKey("exercises")
        var ex = exercises
        exercises?.keys.forEach({key in
            let e = exercises![key] as! NSDictionary

            if(e.valueForKey("enabled") as! String != "true"){
                ex?.removeValueForKey(key)
            }
        })
        return ex!
    }
    
    func doConfig(){
        config.size = 150
        config.backgroundColor = Constants.ui.complimentaryBGColor
        config.spinnerColor = Constants.ui.backgroundColor
        config.titleTextColor = Constants.ui.backgroundColor
        config.foregroundAlpha = 0.4
        
        SwiftLoader.setConfig(config)
        self.menuSetup()
    }
    
    func menuSetup(){
        let size = CGFloat(30.0)
        let imageSize = CGSizeMake(30.0, 50.0)
        
        self.menuIcons = [
            "Home": IonIcons.imageWithIcon(ion_ios_home, iconColor: Constants.ui.complimentaryBGColor, iconSize: size, imageSize: imageSize),
            "Exercises": IonIcons.imageWithIcon(ion_android_walk, iconColor: Constants.ui.complimentaryBGColor, iconSize: size, imageSize: imageSize),
            "Performance": IonIcons.imageWithIcon(ion_ios_pulse, iconColor: Constants.ui.complimentaryBGColor, iconSize: size, imageSize: imageSize),
            "Settings": IonIcons.imageWithIcon(ion_ios_cog, iconColor: Constants.ui.complimentaryBGColor, iconSize: size, imageSize: imageSize),
            "Logout": IonIcons.imageWithIcon(ion_log_out, iconColor: UIColor.redColor(), iconSize: size, imageSize: imageSize)
        ]
    
    }
    
}