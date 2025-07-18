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
    let eggTimes = ["Soft": 3, "Medium": 600, "Hard": 720]
    var timer: Timer?
    @IBOutlet weak var eggLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var alarm: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton, forEvent event: UIEvent) {
        timer?.invalidate()
        let hardness = sender.currentTitle!
        var secondsRemaining = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] in
            if secondsRemaining > 0 {
                eggLabel.text = "remain: \(secondsRemaining)"
                secondsRemaining -= 1
                
                progressBar.progress = 1 - Float(secondsRemaining) / Float(eggTimes[hardness]!)
            } else {
                $0.invalidate()
                eggLabel.text = ("done")
                
                let path = Bundle.main.path(forResource: "alarm_sound.mp3", ofType:nil)!
                let url = URL(fileURLWithPath: path)

                alarm = try? AVAudioPlayer(contentsOf: url)
                alarm?.play()
            }
        }
    }
}
