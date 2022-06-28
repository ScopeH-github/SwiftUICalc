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
    public var base: Decimal
    public var operationNode: [OperationNode]
    
    public init(base: Decimal, operationNode: [OperationNode]) {
        self.base = base
        self.operationNode = operationNode
    }
    
    public func mergeOpNodes() {
        let value = operationNode.reduce(base) { 
            (result: Decimal, element: OperationNode) in
            
            element.op.doCalc(result, element.operand)
        }
        print(value)
    }
}
