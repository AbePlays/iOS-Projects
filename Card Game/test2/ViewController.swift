//
//  ViewController.swift
//  test2
//
//  Created by Abhishek Rawat on 09/01/20.
//  Copyright © 2020 Abhishek Rawat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pScore = 0
    var cScore = 0

    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBAction func dealPressed(_ sender: Any) {
        let leftRandomNumber = arc4random_uniform(13) + 2
        let rightrandomNumber = arc4random_uniform(13) + 2
        
        let leftImageTitle = "card\(leftRandomNumber)"
        let rightImageTitle  = "card\(rightrandomNumber)"
        
        leftImageView.image = UIImage(named: leftImageTitle)
        rightImageView.image = UIImage(named: rightImageTitle)
        
        if leftRandomNumber > rightrandomNumber {
            pScore += 3
        } else if leftRandomNumber < rightrandomNumber {
            cScore += 3
        } else {
            pScore += 1
            cScore += 1
        }
        
        playerScore.text = "\(pScore)"
        cpuScore.text = "\(cScore)"
    }
    
    @IBOutlet weak var playerScore: UILabel!
    
    @IBOutlet weak var cpuScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

