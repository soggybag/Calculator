//
//  ViewController.swift
//  Calculator
//
//  Created by mitchell hudson on 2/7/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userIsInTheMiddleOfTypingAnumber: Bool = false
    var hasDecical: Bool = false
    var operandStack = [Double]()
    var displayValue: Double {
        get {
            return (NSNumberFormatter().numberFromString(display.text!)!.doubleValue)
        }
        
        set {
            display.text = "\(newValue)"
        }
    }
    
    
    // MARK: IBOutlets
    
    @IBOutlet weak var display: UILabel!
    
    
    // MARK: IBActions
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if digit == "." {
            if !hasDecical {
                hasDecical = true
            } else {
                return
            }
        }
        
        if userIsInTheMiddleOfTypingAnumber {
            display.text = display.text! + digit
        } else {
            userIsInTheMiddleOfTypingAnumber = true
            display.text = digit
        }
        
        print(digit)
    }
    
    @IBAction func enter(sender: UIButton) {
        enter()
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingAnumber {
            enter()
        }
        switch operation {
            case "×": performOperation {$0 * $1}
            case "÷": performOperation {$1 / $0}
            case "+": performOperation {$0 + $1}
            case "−": performOperation {$1 - $0}
            case "√": performOperation {sqrt($0)}
            case "sin": performOperation {sin($0)}
            case "cos": performOperation {cos($0)}
            case "π":
                let formatter = NSNumberFormatter()
                formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
                display.text = formatter.stringFromNumber(M_PI)
                enter()
            case "C":
                clear()
            default :break
        }
    }
    
    
    private func enter() {
        userIsInTheMiddleOfTypingAnumber = false
        hasDecical = false
        operandStack.append(displayValue)
        print(operandStack)
    }
    
    func clear() {
        userIsInTheMiddleOfTypingAnumber = false
        hasDecical = false
        operandStack = []
        display.text = "0"
    }
    
    private func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

