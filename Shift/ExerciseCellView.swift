//
//  ExerciseCellView.swift
//  Shift
//
//  Created by Scaria on 4/21/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation
import youtube_ios_player_helper

class ExerciseCellView: UITableViewCell{
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var exerciseName: UILabel!
    
    @IBOutlet weak var videoPlayer: YTPlayerView!
    
    override func layoutSubviews() {
        self.cardViewSetup()
    }
    
    func nameSetup(name: String){
        self.exerciseName!.text = name
    }
    
    
    func cardViewSetup(){
        self.cardView!.alpha = 1.0;
        self.cardView!.layer.masksToBounds = false;
        self.cardView!.layer.cornerRadius = 10.0;
        self.cardView!.layer.shadowOffset = CGSizeMake(-0.1, 0.1)
        self.cardView!.layer.shadowOpacity = 0.2
        
        self.startButton!.layer.cornerRadius = 5.0
    }
    
    func videoSetup(id: String){
        self.videoPlayer!.layer.cornerRadius = 0
        self.videoPlayer!.clipsToBounds = true
        self.videoPlayer!.loadWithVideoId(id)
    }
    
    
}
