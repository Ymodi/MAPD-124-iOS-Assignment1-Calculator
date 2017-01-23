//
//  CalculatorBrain.swift
//  CalCulator
//
//  Created by Yesha Modi on 2017-01-22.
//  Copyright © 2017 Yesha Modi-300895482. All rights reserved.
//  Name: Yesha Modi
//  Student no: 300895482
//  Assignment1 - Basic Calculator App
//  Note: Main logic of the application (Model of the application)
//  Usa of switch, Dictonary, struct, enum

import Foundation

//func multiply(op1: Double, op2: Double) -> Double{
//    return op1 * op2
//}
class CalculatorBrain
{
    private var accmulator = 0.0
    
    func setOperand(operand: Double) {
        accmulator = operand
    }
    
    var operations: Dictionary<String,Operation> = [
        "∏": Operation.Constant(M_PI), //M_PI
        "e": Operation.Constant(M_E), //M_E,
        "√": Operation.UnaryOperation(sqrt),//sqrt,
        "cos" : Operation.UnaryOperation(cos),
        "c" : Operation.Clear,
        "×": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "−": Operation.BinaryOperation({ $0 - $1 }),
        "=": Operation.Equals
    ]
    
    //enum can have computed var and methods --> Pass by value
    // Functions are just type like array, Double etc
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
        case Clear
    }
    
    func performOperations(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accmulator = value
            case .UnaryOperation(let fun):
                accmulator = fun(accmulator)
            case .BinaryOperation(let function):
                executePendingOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accmulator)
            case .Equals: executePendingOperation()
            case .Clear: clearDisplay()
            }
        }
    }
    
    private func clearDisplay(){
        
        accmulator = 0.0
    
    }
    
    private func executePendingOperation(){
        if pending != nil{
            accmulator = pending!.binaryFunction(pending!.firstOperand, accmulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    //Struct like enum pass by Value , Pass by refrence lives in a heap
    struct  PendingBinaryOperationInfo {
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
    }
    
    // var result is read only property
    var result : Double {
        get{
            return accmulator
        }
    }
}


