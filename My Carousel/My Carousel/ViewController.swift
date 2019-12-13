//
//  ViewController.swift
//  My Carousel
//
//  Created by Abhishek Rawat on 13/12/19.
//  Copyright © 2019 Abhishek Rawat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageIndicator: UIPageControl!
    
    let images = [#imageLiteral(resourceName: "05"),#imageLiteral(resourceName: "02"),#imageLiteral(resourceName: "04"),#imageLiteral(resourceName: "03")]
    var imagePosition = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImage()
        pageIndicator.numberOfPages = images.count
    }

    func updateImage() {
        imageView.image = images[imagePosition]
        pageIndicator.currentPage = imagePosition
    }

    @IBAction func nextPressed(_ sender: UIButton) {
        imagePosition += 1
        
        if imagePosition + 1 > images.count {
            imagePosition = 0
        }
        updateImage()
    }
    @IBAction func prevPressed(_ sender: UIButton) {
        imagePosition -= 1
        
        if imagePosition < 0 {
            imagePosition = images.count - 1
        }
        updateImage()
    }
}

