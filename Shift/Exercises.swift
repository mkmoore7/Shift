//
//  Exercises.swift
//  Shift
//
//  Created by Meredith Moore on 4/18/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation
import CoreMotion
import UIKit

class Exercises: UIViewController {
    
    @IBOutlet weak var xAcc: UILabel!
    @IBOutlet weak var yAcc: UILabel!
    @IBOutlet weak var zAcc: UILabel!
    @IBOutlet weak var xRot: UILabel!
    @IBOutlet weak var yRot: UILabel!
    @IBOutlet weak var zRot: UILabel!

    
    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer()) //add a gesture recognizer
        
        //Set Motion Properties
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.gyroUpdateInterval = 0.2
        
        //Start Recording Data
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            
            self.outputAccData(accelerometerData!.acceleration)
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
        motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: { (gyroData: CMGyroData?, NSError) -> Void in
            self.outputRotData(gyroData!.rotationRate)
            if (NSError != nil){
                print("\(NSError)")
            }
        })
        
        super.viewDidLoad()
        
    }
    
    func outputAccData(acceleration: CMAcceleration){
        xAcc?.text = "\(acceleration.x).2fg"
        yAcc?.text = "\(acceleration.y).2fg"
        zAcc?.text = "\(acceleration.z).2fg"
    }
    
    func outputRotData(gyro: CMRotationRate){
        xRot?.text = "\(gyro.x).2fg"
        yRot?.text = "\(gyro.y).2fg"
        zRot?.text = "\(gyro.z).2fg"
    }
    
    
}