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
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos)
    ]
    
    mutating func setOperand(_ newValue:Double) {
        accumulator = newValue
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    mutating func performOperation(_ op: String) {
        if let operation = operations[op] {
            switch operation {
            case .constant(let associatedConstantValue):
                accumulator = associatedConstantValue
            case .unaryOperation(let associatedUnaryOperation):
                if let operand = accumulator {
                    accumulator = associatedUnaryOperation(operand)
                }
            }
        }
//        switch op {
//        case "π":
//            accumulator = Double.pi
//        case "√":
//            if let operand = accumulator {
//                accumulator = sqrt(operand)
//            }
//        default:
//            print(1)
//            break;
//        }
    }
}
