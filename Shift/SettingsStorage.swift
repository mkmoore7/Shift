//
//  SettingsStorage.swift
//  Shift
//
//  Created by Scaria on 4/21/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation
import SwiftySettings
import SwiftyUserDefaults


class SettingsStorage: SettingsStorageType{
    var storage = Config.sharedInstance.defaults
    
    
    subscript(key: String) -> Bool? {
        get {
            return Defaults[key].bool
        }
        set {
            Defaults[key] = newValue
        }
    }
    subscript(key: String) -> Float? {
        get {
            return Float(Defaults[key].doubleValue)
        }
        set {
            Defaults[key] = newValue
        }
    }
    subscript(key: String) -> Int? {
        get {
            return Defaults[key].int
        }
        set {
            Defaults[key] = newValue
        }
    }
    subscript(key: String) -> String? {
        get {
            return Defaults[key].string
        }
        set {
            Defaults[key] = newValue
        }
    }
    
    

}
