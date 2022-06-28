// CalcCore.swift
// SwiftUICalc
//
// Created by Scope.H on 2022/06/28
//

import SwiftUI
import Foundation

public enum Operator {
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
}

public struct OperationNode {
    public var op: Operator    // Operator
    public var operand: Decimal
    
    public init (op: Operator, operand: Decimal) {
        self.op = op
        self.operand = operand
    }
}

public struct Operation {
    public var baseNumber: Decimal
    public var operationNode: [OperationNode]
    
    public init(baseNumber: Decimal, operationNode: [OperationNode]) {
        self.baseNumber = baseNumber
        self.operationNode = operationNode
    }
    
    public mutating func mergePriorityNode() {
        var newNodes: [OperationNode] = []
        
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
                    newNodes.append(OperationNode(op: latestNode.op, operand: newOperand))
                }
            } else {
                newNodes.append(node)
            }
        }
        
        operationNode = newNodes
    }
    
    public func mergeOpNodes() {
        let value = operationNode.reduce(baseNumber) { 
            (result: Decimal, element: OperationNode) in
            
            element.op.doCalc(result, element.operand)
        }   // reduce has problem(can't calc *, / first) -> I do not support (), maybe...
        print(value)
    }
}
