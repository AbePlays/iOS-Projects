//
//  ViewController.swift
//  Learn 1-10 in Japanese
//
//  Created by Abhishek Rawat on 10/12/19.
//  Copyright © 2019 Abhishek Rawat. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player : AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        playSound(file: sender.currentTitle!)
    }
    
    func playSound(file: String) {
        
        let url = Bundle.main.url(forResource: file, withExtension: "m4a")

        player = try! AVAudioPlayer(contentsOf: url!)

        player.play()
    }
    
}

