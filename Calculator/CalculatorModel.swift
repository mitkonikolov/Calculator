//
//  CalculaterModel.swift
//  Calculator/Users/Mitko/Developer/Calculator/Calculator/Base.lproj/Main.storyboard
//
//  Created by Mitko Nikolov on 8/11/17.
//  Copyright © 2017 Mitko Nikolov. All rights reserved.
//

import Foundation

struct CalculatorModel {
    private var accumulator: Double?
    private var pbo: PendingBinaryOperation?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "AC" : Operation.constant(0),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "sin" : Operation.unaryOperation(sin),
        "tg" : Operation.unaryOperation(tan),
        "±" : Operation.unaryOperation({ $0 * (-1) }),
        "+" : Operation.binaryOperation({ $0 + $1}),
        "-" : Operation.binaryOperation({ $0 - $1}),
        "*" : Operation.binaryOperation({ $0 * $1}),
        "/" : Operation.binaryOperation({ $0 / $1}),
        "=" : Operation.equals
    ]
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    mutating func setOperand(_ newValue:Double) {
        accumulator = newValue
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
            case .binaryOperation(let function):
                if accumulator != nil {
                    pbo = PendingBinaryOperation(function: function,
                                                 firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pbo != nil && accumulator != nil {
            accumulator = pbo!.perform(with: accumulator!)
            pbo = nil
        }
    }
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand:Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
}









