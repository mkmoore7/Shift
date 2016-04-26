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
import SCLAlertView
import SpriteKit

class Exercises: UIViewController {
    
    @IBOutlet weak var navigationMenu: UIBarButtonItem!
    
    var player: SKSpriteNode?
    //var targets: [SKSpriteNode] = []
    //var dots: [SKSpriteNode] = []
    var dot0, dot1, dot2, dot3, dot4, dot5, dot6, dot7 : SKSpriteNode?
    var target0, target1, target2, target3, target4, target5, target6, target7 : SKSpriteNode?
    var motionManager = CMMotionManager()
    var accX, accY, accZ, posX, posY: SKLabelNode?
    var x, y: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //reveal menu controller stuff
        if self.revealViewController() != nil {
            navigationMenu.target = self.revealViewController()
            navigationMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //alert that explains how the game works
        SCLAlertView().showInfo("How to Play ", subTitle: "Hold the phone to your chest, and shift your weight towards the orange target until you hear a ding.", closeButtonTitle: "Start")
        
        
        //attach the scene to the file
        let skView = SKView(frame: self.view.frame)
        let scene = SKScene(fileNamed: "ExerciseScene")
        scene!.scaleMode = .AspectFit
        
        skView.presentScene(scene)
        view.addSubview(skView)
        
        
        //setup the player and targets (super gross code... but forcing it right now)
        player = skView.scene!.childNodeWithName("player") as? SKSpriteNode
        target0 = skView.scene!.childNodeWithName("target0") as? SKSpriteNode
        target1 = skView.scene!.childNodeWithName("target1") as? SKSpriteNode
        target2 = skView.scene!.childNodeWithName("target2") as? SKSpriteNode
        target3 = skView.scene!.childNodeWithName("target3") as? SKSpriteNode
        target4 = skView.scene!.childNodeWithName("target4") as? SKSpriteNode
        target5 = skView.scene!.childNodeWithName("target5") as? SKSpriteNode
        target6 = skView.scene!.childNodeWithName("target6") as? SKSpriteNode
        target7 = skView.scene!.childNodeWithName("target7") as? SKSpriteNode
        
        dot0 = skView.scene!.childNodeWithName("dot0") as? SKSpriteNode
        dot1 = skView.scene!.childNodeWithName("dot1") as? SKSpriteNode
        dot2 = skView.scene!.childNodeWithName("dot2") as? SKSpriteNode
        dot3 = skView.scene!.childNodeWithName("dot3") as? SKSpriteNode
        dot4 = skView.scene!.childNodeWithName("dot4") as? SKSpriteNode
        dot5 = skView.scene!.childNodeWithName("dot5") as? SKSpriteNode
        dot6 = skView.scene!.childNodeWithName("dot6") as? SKSpriteNode
        dot7 = skView.scene!.childNodeWithName("dot7") as? SKSpriteNode
        
        target1!.hidden = true
        target2!.hidden = true
        target3!.hidden = true
        target4!.hidden = true
        target5!.hidden = true
        target6!.hidden = true
        target7!.hidden = true
        dot0!.hidden = true
        
        
        accX = skView.scene!.childNodeWithName("accX") as? SKLabelNode
        accY = skView.scene!.childNodeWithName("accY") as? SKLabelNode
        accZ = skView.scene!.childNodeWithName("accZ") as? SKLabelNode
        posX = skView.scene!.childNodeWithName("posX") as? SKLabelNode
        posY = skView.scene!.childNodeWithName("posY") as? SKLabelNode
        
        //move the cursor based on acceleration values.
        
        motionDataSetup()
        
        
    }
    
    
    func outputAccData(acceleration: CMAcceleration){
        
        //accX?.text = "\(acceleration.x).2fg"
        //accY?.text = "\(acceleration.y).2fg"
        //accZ?.text = "\(acceleration.z).2fg"
        print("Acceleration: (\(acceleration.x), \(acceleration.y), \(acceleration.z)")
    }
    
    func outputPosData(){
        //put the position of the cursor here
        posX?.text = "\(player!.position.x).2fg"
        posY?.text = "\(player!.position.y).2fg"
        print("Player Position: \(player!.position.x) , \(player!.position.y)")
    }
    
    func movePlayer(acc: CMAcceleration){
        
        //need a bounding box
        x = player!.position.x
        y = player!.position.y
        
        //create a bounding box for the player to stay in. This should freeze it at the edges
        if(x > 20){
            if(x < 355){
                if(y > 220){
                    if(y < 585){
                        x = x! + CGFloat(20 * acc.x)
                        y = y! - CGFloat(20 * acc.z)
                        
                        player!.position = CGPoint(x: x!, y: y!)
                        print("position changed")
                    }
                    else{
                        print("top edge")
                        y = 584
                    }
                    
                }
                else{
                    print("bottom edge")
                    y = 221
                }
                
            }
            else{
                print("right edge")
                x = 354
            }
            
        }else{
            print("left edge")
            x = 21
        }
        
        outputPosData()
    }
    
    func motionDataSetup(){
        //Set Motion Properties
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.gyroUpdateInterval = 0.2
        
        //Start Recording Data
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            
            if( accelerometerData != nil){
                self.outputAccData(accelerometerData!.acceleration)
                self.movePlayer(accelerometerData!.acceleration)
            }
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
        motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: { (gyroData: CMGyroData?, NSError) -> Void in
            //self.outputRotData(gyroData!.rotationRate)
            if (NSError != nil){
                print("\(NSError)")
            }
        })
    }
    
}