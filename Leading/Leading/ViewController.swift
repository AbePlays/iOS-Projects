//
//  ViewController.swift
//  Leading
//
//  Created by Abhishek Rawat on 15/12/19.
//  Copyright © 2019 Abhishek Rawat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
}

