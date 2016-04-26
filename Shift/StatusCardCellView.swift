//
//  StatusCardCellView.swift
//  Shift
//
//  Created by Scaria on 4/20/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation
import ionicons


class StatusCardCellView: UITableViewCell{

    @IBOutlet weak var userNameLabel: UILabel!

    @IBOutlet weak var statusImage: UIImageView!

    @IBOutlet weak var statusMessage: UITextView!
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var lastLoginLabel: UILabel!
    override func layoutSubviews() {
        self.cardViewSetup()
        self.nameSetup();
        self.imageSetup()
    }
    
    
    
    func nameSetup(){
        let usename = LoginServices.sharedInstance.username()
        let profilePicUrl = LoginServices.sharedInstance.profilePicUrl()
        let lastLogin = LoginServices.sharedInstance.lastLogin()
        
        var image:UIImage
        do{
            let profilePicData = try NSData(contentsOfURL: NSURL(string: profilePicUrl)!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            image  = UIImage(data: profilePicData)!
        } catch{
            image = IonIcons.imageWithIcon(ion_ios_person, size: 30.0, color: Constants.ui.complimentaryBGColor)
        }
        
        self.statusImage.image = image
        self.userNameLabel.text? = "Welcome \(usename)!"
        let lastLoginString = NSDateFormatter.localizedStringFromDate(lastLogin, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        self.lastLoginLabel.text? = "Last login : \(lastLoginString)"
        //self.statusMessage.text? = "Hello, you haven't done any exercises\n today"
    }
    
    
    func cardViewSetup(){
        self.cardView!.alpha = 1.0;
        self.cardView!.layer.masksToBounds = false;
        self.cardView!.layer.cornerRadius = 15.0;
        self.cardView!.layer.shadowOffset = CGSizeMake(-0.1, 0.1)
        self.cardView!.layer.shadowOpacity = 0.2
    }
    
    func imageSetup(){
        self.statusImage!.layer.cornerRadius = 20.0
        self.statusImage!.clipsToBounds = true
        self.statusImage!.contentMode = UIViewContentMode.ScaleAspectFit
        self.statusImage!.backgroundColor = UIColor.clearColor()
    }
}