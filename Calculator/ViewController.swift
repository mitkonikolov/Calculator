//
//  ViewController.swift
//  Calculator
//
//  Created by Mitko Nikolov on 8/10/17.
//  Copyright © 2017 Mitko Nikolov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var model = CalculatorModel()
    
    var userIsInTheMiddleOfTyping = false
    private var userEnteredADot = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit: String = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            if digit != "." || userEnteredADot != true {
                display.text = display.text! + digit
            }
        }
        else {
            if digit != "." || userEnteredADot != true {
                display.text = digit
                userIsInTheMiddleOfTyping = true
            }
        }
        
        if digit == "." {
            userEnteredADot = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            model.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
            userEnteredADot = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            model.performOperation(mathematicalSymbol)
        }
        if let v = model.result {
            display.text = String(v)
        }
    }
    
    @IBOutlet weak var display: UILabel!
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
}
