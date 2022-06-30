// CalcCore.swift
// SwiftUICalc
//
// Created by Scope.H on 2022/06/28
//

import SwiftUI
import Foundation

public enum CalcOperator {
    case plus, minus, times, divide
    
    public var doCalc : (Decimal, Decimal) -> Decimal {
        switch self {
        case .plus:
            return ( + )
        case .minus:
            return ( - )
        case .times:
            return ( * )
        case .divide:
            return ( / )
        }
    }
    
    public var calcSymbol: String {
        switch self {
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .times:
            return "×"
        case .divide:
            return "÷"
        }
    }
}

public struct CalcOperationNode {
    var op: CalcOperator    // Operator
    var operand: Decimal
    
    public init (op: CalcOperator, operand: Decimal) {
        self.op = op
        self.operand = operand
    }
}

public struct CalcOperation {
    public var baseNumber: Decimal
    public var operationNode: [CalcOperationNode]
    
    public init () {
        self.baseNumber = 0
        self.operationNode = [CalcOperationNode]()
    }
    
    public init(baseNumber: Decimal, operationNode: [CalcOperationNode]) {
        self.baseNumber = baseNumber
        self.operationNode = operationNode
    }
    
    public mutating func mergePriorityNode() {
        var newNodes: [CalcOperationNode] = []
        
        for node in self.operationNode {
            
            if node.op == .times || node.op == .divide {
                let base: Decimal
                if newNodes.isEmpty {
                    base = baseNumber
                    let newOperand = node.op.doCalc(base, node.operand)
                    baseNumber = newOperand
                } else {
                    let latestNode = newNodes.removeLast()    // removeLast() returns Value
                    base = latestNode.operand
                    let newOperand = node.op.doCalc(base, node.operand)
                    newNodes.append(CalcOperationNode(op: latestNode.op, operand: newOperand))
                }
            } else {
                newNodes.append(node)
            }
        }
        
        operationNode = newNodes
    }
    
    public func mergeOpNodes() -> Decimal {
        let value = operationNode.reduce(baseNumber) { 
            (result: Decimal, element: CalcOperationNode) in
            
            element.op.doCalc(result, element.operand)
        }
        return value
    }
    
    public mutating func calcResult() -> Decimal {
        mergePriorityNode()
        return mergeOpNodes()
    }
    
    public func operationString() -> String {
        return self.operationNode.reduce("\(baseNumber)") {
            (result: String, element: CalcOperationNode) in
            result + " " + element.op.calcSymbol + " " + "\(element.operand)"
        }
    }
}
