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
    
    let allExercises:Array<String> = ["Clock Reach", "Side Hip Raise"]
    let exerciseInfo = [
        "Clock Reach-enable" : true,
        "Clock Reach-video": "yi01KXc7laY",
        "Side Hip Raise-enable": true,
        "Side Hip Raise-video": "eW0xZApmUyo"
    ]

    
    private override init(){
        self.config =  SwiftLoader.Config();
        self.menuIcons = [:]
        
        if(defaults.arrayForKey("exercises") == nil){
            defaults.setObject(allExercises, forKey: "exercises")
            defaults.setValuesForKeysWithDictionary(exerciseInfo)
        }
    }
    
    func getExercises() -> (exercises: Array<String>, videos: Array<String>){
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let exercises = defaults.arrayForKey("exercises")
        var ex:Array<String> = []
        var videos:Array<String> = []
        exercises?.forEach({exercise in
            if(defaults.valueForKey("\(exercise)-enable") as! Bool){
                ex.append(exercise as! String)
                videos.append(defaults.stringForKey("\(exercise)-video")!)
            }
        })
        return (ex, videos)
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