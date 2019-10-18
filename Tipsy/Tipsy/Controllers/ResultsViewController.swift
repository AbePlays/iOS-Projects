import UIKit

class ResultsViewController: UIViewController {
    
    var perHead: String?
    
    var person: String?
    
    var tipPercent: String?

    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = perHead
        settingsLabel.text = "Split between \(person!) people, with \(tipPercent!.dropLast(2))% tip."
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var settingsLabel: UILabel!
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
