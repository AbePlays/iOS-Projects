//
//  ViewController.swift
//  Catch the Kenny
//
//  Created by Abhishek Rawat on 08/01/20.
//  Copyright © 2020 Abhishek Rawat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var kennyTimer = Timer()
    var highScore = 0

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let gestureRecog1 = UITapGestureRecognizer(target: self, action: #selector(setScore))
        let gestureRecog2 = UITapGestureRecognizer(target: self, action: #selector(setScore))
        let gestureRecog3 = UITapGestureRecognizer(target: self, action: #selector(setScore))
        let gestureRecog4 = UITapGestureRecognizer(target: self, action: #selector(setScore))
        let gestureRecog5 = UITapGestureRecognizer(target: self, action: #selector(setScore))
        let gestureRecog6 = UITapGestureRecognizer(target: self, action: #selector(setScore))
        let gestureRecog7 = UITapGestureRecognizer(target: self, action: #selector(setScore))
        let gestureRecog8 = UITapGestureRecognizer(target: self, action: #selector(setScore))
        let gestureRecog9 = UITapGestureRecognizer(target: self, action: #selector(setScore))
        
        kenny1.addGestureRecognizer(gestureRecog1)
        kenny2.addGestureRecognizer(gestureRecog2)
        kenny3.addGestureRecognizer(gestureRecog3)
        kenny4.addGestureRecognizer(gestureRecog4)
        kenny5.addGestureRecognizer(gestureRecog5)
        kenny6.addGestureRecognizer(gestureRecog6)
        kenny7.addGestureRecognizer(gestureRecog7)
        kenny8.addGestureRecognizer(gestureRecog8)
        kenny9.addGestureRecognizer(gestureRecog9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        hideKenny()
        
        counter = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTime), userInfo: nil, repeats: true)
        kennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
    }
    
    @objc func hideKenny() {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int.random(in: 0...8)
        kennyArray[random].isHidden = false
    }
    
    @objc func setScore() {
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    @objc func setTime() {
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            kennyTimer.invalidate()
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            if score > highScore {
                highScore = score
                highScoreLabel.text = "High Score : \(highScore)"
                UserDefaults.standard.set(highScore, forKey: "HighScore")
            }
            
            let alert = UIAlertController(title: "Time Over", message: "Want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "\(self.score)"
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setTime), userInfo: nil, repeats: true)
                self.kennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replay)
            
            self.present(alert, animated: true, completion: nil)
        }
    }


}

