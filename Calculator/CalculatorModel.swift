//
//  CalculaterModel.swift
//  Calculator
//
//  Created by Mitko Nikolov on 8/11/17.
//  Copyright © 2017 Mitko Nikolov. All rights reserved.
//

import Foundation

struct CalculatorModel {
    private var accumulator: Double?
    
    mutating func setOperand(_ newValue:Double) {
        accumulator = newValue
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    mutating func performOperation(_ op: String) {
        switch op {
        case "√":
            accumulator = sqrt(accumulator!)
        case "π":
            accumulator = Double.pi
        default:
            break;
        }
    }
}
