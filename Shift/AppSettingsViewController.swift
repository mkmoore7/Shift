//
//  Settings.swift
//  Shift
//
//  Created by Meredith Moore on 4/18/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation
import ionicons
import SwiftySettings.Swift

class AppSettingsViewController: SwiftySettingsViewController {
    var storage:SettingsStorage = SettingsStorage()
    
    @IBOutlet weak var navigationMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        if self.revealViewController() != nil {
            navigationMenu.target = self.revealViewController()
            navigationMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        super.viewDidLoad()
        loadSettingsTopDown()

        
    }
    
    
    func loadSettingsTopDown() {
        /* Top Down settings */
        settings = SwiftySettings(storage: storage, title: "shiftapp") {[
                Section(title: "Exercises") {[
                    Switch(key: "Cloak Reach", title: "Cloak Reach", icon: IonIcons.imageWithIcon(ion_ios_clock, iconColor: Constants.ui.complimentaryBGColor, iconSize: 20.0, imageSize: CGSizeMake(40.0, 40.0))!),
                    Switch(key: "Side Hip Raise", title: "Side Hip Raise", icon: IonIcons.imageWithIcon(ion_ios_body, iconColor: Constants.ui.complimentaryBGColor, iconSize: 20.0, imageSize: CGSizeMake(40.0, 40.0))!)
                ]},
            
                Section(title: "Notifications") {[
                    Switch(key: "notification", title: "Exercise Notification", icon: IonIcons.imageWithIcon(ion_ios_information, iconColor: Constants.ui.complimentaryBGColor, iconSize: 20.0, imageSize: CGSizeMake(40.0, 40.0))!),
                    TextField(key: "alarm-time", title: "Alarm Time", secureTextEntry: false),
                    Slider(key: "volume", title: "Alarm Volume",
                                    minimumValueImage: IonIcons.imageWithIcon(ion_ios_volume_low, size: 20.0, color: Constants.ui.complimentaryBGColor)!,
                                    maximumValueImage: IonIcons.imageWithIcon(ion_ios_volume_high, size: 20.0, color: Constants.ui.complimentaryBGColor)!,
                                    minimumValue: 0,
                                    maximumValue: 100)
                            
                 ]}
            ]}
        }
}