//
//  Config.swift
//  Shift
//
//  Created by Scaria on 4/20/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation
import SwiftLoader

class Config: NSObject {
    
    static let sharedInstance = Config()
    var config : SwiftLoader.Config;
    
    private override init(){
        self.config =  SwiftLoader.Config();
    }
    
    func doConfig(){
        config.size = 150
        config.backgroundColor = Constants.ui.complimentaryBGColor
        config.spinnerColor = Constants.ui.backgroundColor
        config.titleTextColor = Constants.ui.backgroundColor
        config.foregroundAlpha = 0.4
        
        SwiftLoader.setConfig(config)
    }
}