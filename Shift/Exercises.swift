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
    var playerRestPosition:CGPoint?
    var radius:Double?
    var accelaration : CMAcceleration = CMAcceleration(x: 0.0,y: 0.0,z: 0.0)
    var speed: CMAcceleration = CMAcceleration(x: 0.0,y: 0.0,z: 0.0)
    var position: CMAcceleration = CMAcceleration(x: 0.0,y: 0.0,z: 0.0)
    
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
        self.playerRestPosition = player!.position
        self.position = CMAcceleration(x: Double(self.playerRestPosition!.x), y: Double(self.playerRestPosition!.y),z: 0.0)
        
        target0 = skView.scene!.childNodeWithName("target0") as? SKSpriteNode
        
        self.radius = Double(target0!.position.y - self.playerRestPosition!.y)
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
//        let deltaX :Double = (acc.x - self.accelaration.x)
//        let deltaY :Double = (acc.y - self.accelaration.y)
//        
//        self.accelaration.x += 2.0 * deltaX
//        self.accelaration.y += 2.0 * deltaY
//        
//        self.speed.x += 2.0 * deltaX
//        self.speed.y += 2.0 * deltaY
//        
//        self.position.x += 2.0 * deltaX
//        self.position.y += 2.0 * deltaY
//        let DT = 0.2
//        
//        self.position.x = self.position.x + self.speed.x * DT + 0.5 * self.accelaration.x * DT * DT
//        self.position.y = self.position.y + self.speed.y * DT + 0.5 * self.accelaration.y * DT * DT
//        self.speed.x = self.speed.x + self.accelaration.x * DT;
//        self.speed.y = self.speed.y + self.accelaration.y * DT;
//        self.accelaration.x = acc.x
//        self.accelaration.y = acc.y
//        
//        if( pow((self.position.x - Double(self.playerRestPosition!.x)), 2.0) + pow(self.position.y - Double(self.playerRestPosition!.y), 2.0) <= (radius! * radius!)){
//            self.player!.position = CGPoint(x: self.position.x,y: self.position.y)
//        }
//        
        
        
        
        
     
        
        //need a bounding box
        let x:Double = Double(player!.position.x) + ((acc.x - self.accelaration.x)/0.2 * 50.0)
        let y:Double = Double(player!.position.y) + ((acc.y - self.accelaration.y)/0.2 * 50.0)
        
        //create a bounding box for the player to stay in. This should freeze it at the edges
        
        if( pow((x - Double(self.playerRestPosition!.x)), 2.0) + pow(y - Double(self.playerRestPosition!.y), 2.0) <= (radius! * radius!)){
            self.player!.position = CGPoint(x: x,y: y)
        
        }
        self.accelaration.x = acc.x
        self.accelaration.y = acc.y
        
        
        
//        if(x > 20){
//            if(x < 355){
//                if(y > 220){
//                    if(y < 585){
//                        x = x! + CGFloat(20 * acc.x)
//                        y = y! - CGFloat(20 * acc.z)
//                        
//                        player!.position = CGPoint(x: x!, y: y!)
//                        print("position changed")
//                    }
//                    else{
//                        print("top edge")
//                        y = 584
//                    }
//                    
//                }
//                else{
//                    print("bottom edge")
//                    y = 221
//                }
//                
//            }
//            else{
//                print("right edge")
//                x = 354
//            }
//            
//        }else{
//            print("left edge")
//            x = 21
//        }
//        
        outputPosData()
    }
    
    func motionDataSetup(){
        //Set Motion Properties
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.gyroUpdateInterval = 0.2
        
        //Start Recording Data
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (accelerometerData: CMAccelerometerData?, error:NSError?) -> Void in
            if( error == nil){
                //self.outputAccData(accelerometerData!.acceleration)
                self.movePlayer(accelerometerData!.acceleration)
            }
        }
        
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue()!) { [weak self](accelerometerData: CMDeviceMotion?, error:NSError?) -> () in
            if(error != nil){
               // self.outputAccData(accelerometerData!.gravity)
                //self!.movePlayer(accelerometerData!.gravity.x, yVal: accelerometerData!.gravity.y)
            
            }
        }
        motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: { (gyroData: CMGyroData?, NSError) -> Void in
            //self.outputRotData(gyroData!.rotationRate)
            if (NSError != nil){
                print("\(NSError)")
            }
        })
    }
    
    deinit{
        motionManager.stopGyroUpdates()
    }
    
    
}