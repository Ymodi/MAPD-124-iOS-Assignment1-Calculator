//
//  ViewController.swift
//  CalCulator
//
//  Created by Yesha Modi on 2017-01-20.
//  Copyright © 2017 Yesha Modi-300895482. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel! //? = nil
    //Implicity unwrap optionals
    private var middleOfTypingNumber = false
    
    @IBAction private func touchDigit(_ sender: UIButton )
    {
        let digitButton = sender.currentTitle!
        if middleOfTypingNumber {
            let textInDisplay = display.text!
            display.text = textInDisplay + digitButton
        } else {
            display.text = digitButton
        }
        middleOfTypingNumber = true
       // print("digitButton \(digitButton) digit")
    }
    
    private var displayButtonValue: Double // making it computed property
    {
        get{ return Double(display.text!)! }
        set{ display.text = String(newValue) //Converting double (newValue) to string
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if middleOfTypingNumber {
            brain.setOperand(operand: displayButtonValue)
        }
        middleOfTypingNumber = false
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperations(symbol: mathematicalSymbol)
            displayButtonValue = brain.result
        }
    }
    
}

