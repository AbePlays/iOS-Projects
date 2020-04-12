//
//  ViewController.swift
//  Twittermenti
//
//  Created by Abhishek Rawat on 17/07/2019.
//

import UIKit
import SwifteriOS
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let tweetCount = 100
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    let swifter = Swifter(consumerKey: "SqRBsMEn08a5dP8Bu4YAbdapL", consumerSecret: "1C3MJdLokvzfPMkS1uvjVVQOgDBrUvC8mn0hzgIEv8ysKcSTkR")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        if let searchText = textField.text {
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended, success: { (results, metadata) in
                var tweets = [TweetSentimentClassifierInput]()
                
                for i in 0..<self.tweetCount {
                    if let data = results[i]["full_text"].string {
                        let tweetsForClassification = TweetSentimentClassifierInput(text: data)
                        tweets.append(tweetsForClassification)
                    }
                }
                
                do {
                    let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
                    var score = 0
                    for prediction in predictions {
                        let sentiment = prediction.label
                        
                        if sentiment == "Pos" {
                            score += 1
                        } else if sentiment == "Neg" {
                            score -= 1
                        }
                    }
                    
                    if score > 20 {
                        self.sentimentLabel.text = "😍"
                    } else if score > 10 {
                        self.sentimentLabel.text = "😀"
                    } else if score > 0 {
                        self.sentimentLabel.text = "🙂"
                    } else if score == 0 {
                        self.sentimentLabel.text = "😐"
                    } else if score > -10 {
                        self.sentimentLabel.text = "😕"
                    } else if score > -20 {
                        self.sentimentLabel.text = "😡"
                    } else {
                        self.sentimentLabel.text = "🤮"
                    }
                    
                } catch {
                    print("Error in prediction")
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        
    }
    
}

