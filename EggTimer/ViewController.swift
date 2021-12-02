//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let eggTimes = ["Soft": 30,
                    "Medium": 480,
                    "Hard": 720]
    
    var timer = Timer()
    
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
               
        let hardness = sender.currentTitle!
        let timeToCook = eggTimes[hardness]!
        var secondsRemaining = timeToCook
        var minutes: Int = timeToCook/60
        var seconds: Int = timeToCook%60
        
        if seconds < 10 {
            self.timeLabel.text = "\(minutes):0\(seconds)"
        } else {
            self.timeLabel.text = "\(minutes):\(seconds)"
        }
        
        timer.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                if secondsRemaining > 0 {
                    secondsRemaining -= 1
                    minutes = secondsRemaining/60
                    seconds = secondsRemaining%60
                    
                    if seconds < 10 {
                        self.timeLabel.text = "\(minutes):0\(seconds)"
                    } else {
                        self.timeLabel.text = "\(minutes):\(seconds)"
                    }
                    
                    self.progressView.progress = 1 - (Float(secondsRemaining) / Float(timeToCook))
                } else {
                    Timer.invalidate()
                    self.timeLabel.text = "DONE!"
                    self.playSound()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        self.timeLabel.text = "How do you like your eggs?"
                        self.progressView.progress = 0
                    }
                }
            }
    }
    
    func playSound() {
            let url = Bundle.main.url(forResource: "okay-everybody-lets-eat", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    
    
}
