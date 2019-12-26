import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = K.appName
//
//        let text = "⚡️FlashChat"
//
//        var count = 0.0
//
//        for letter in text {
//            Timer.scheduledTimer(withTimeInterval: 0.1 * count, repeats: false) { (Timer) in
//                self.titleLabel.text?.append(letter)
//            }
//            count += 1
//        }
       
    }
    

}
