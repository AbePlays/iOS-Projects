import UIKit

class ViewController: UIViewController {
    
    private var isFinishedTyping: Bool = true
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("The fuck is going on here")
            }
            return number
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var calculator = CalculatorLogic()    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        isFinishedTyping = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }            
        }
    
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        if let numValue = sender.currentTitle {
            
            if isFinishedTyping == true {
                displayLabel.text = numValue
                isFinishedTyping = false
            } else {
                if numValue == "." {
                    let isInt = floor(displayValue) == Double(displayValue)
                    if isInt == false {
                        return
                    }
                }
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }

}

