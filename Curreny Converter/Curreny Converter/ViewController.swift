//
//  ViewController.swift
//  Curreny Converter
//
//  Created by Abhishek Rawat on 27/02/20.
//  Copyright © 2020 Abhishek Rawat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var inrLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getPressed(_ sender: Any) {
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=ec92600ffb796a4f78838407d682a518")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                if data != nil {
                    do {
                        let result = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        DispatchQueue.main.async {
                            if let rates = result["rates"] as? [String : Any] {
                                self.cadLabel.text = "CAD : \(rates["CAD"]! as! Double)"
                                self.chfLabel.text = "CHF : \(rates["CHF"]! as! Double)"
                                self.gbpLabel.text = "GBP : \(rates["GBP"]! as! Double)"
                                self.jpyLabel.text = "JPY : \(rates["JPY"]! as! Double)"
                                self.inrLabel.text = "INR : \(rates["INR"]! as! Double)"
                                self.tryLabel.text = "TRY : \(rates["TRY"]! as! Double)"
                                
                            }
                        }
                    } catch {
                        print("Error parsing")
                    }
                }
            }
        }
        task.resume()
    }
    
}

