//
//  ViewController.swift
//  Rock Paper Scissor
//
//  Created by Abhishek Rawat on 09/12/19.
//  Copyright © 2019 Abhishek Rawat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let slides = [#imageLiteral(resourceName: "One"), #imageLiteral(resourceName: "Two"), #imageLiteral(resourceName: "Three")]
    let result = [#imageLiteral(resourceName: "rock"), #imageLiteral(resourceName: "paper"), #imageLiteral(resourceName: "scissor")]
    var now = 2
    var timer = Timer()

    @IBOutlet weak var imageViewer: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startButton(_ sender: UIButton) {

        timer.invalidate()

        timer = Timer.scheduledTimer(timeInterval: 0.6, target:self, selector: #selector(countDown), userInfo:nil, repeats: true)
        
    }
    
    @objc func countDown() {
        
        if now != -1 {
            imageViewer.image = slides[now]
            now -= 1
        } else {
            now = 2
            timer.invalidate()
            imageViewer.image = result.randomElement()
        }
        
    }
    
}

