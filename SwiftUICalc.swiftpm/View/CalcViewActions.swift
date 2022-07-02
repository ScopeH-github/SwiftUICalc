import SwiftUI

var currentNum: Decimal = 0
var currentOperator: CalcOperator?
var currentOperation: CalcOperation = CalcOperation()

public func calcButtonAction(key: CalcButtons, _ currentNumber: inout String, _ operationText: inout String) {
    switch key {
    case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
        if currentNum == 0 && !currentNumber.isEmpty && currentNumber != "0." {
            currentNumber.removeAll()
            currentOperator = nil
            currentOperation = CalcOperation()
        }
        currentNumber += key.rawValue
        currentNum = numberToDecimal(&currentNumber)
    case .zero, .doubleZero:
        if !currentNumber.isEmpty {
            if currentNum == 0 {
                currentNumber.removeAll()
                currentOperator = nil
                currentOperation = CalcOperation()
            }
            currentNumber += key.rawValue
            currentNum = numberToDecimal(&currentNumber)
        }
    case .floatPoint:
        if currentNumber.isEmpty {
            currentNumber += "0" + key.rawValue
        }
        if !currentNumber.contains(key.rawValue) {
            currentNumber += key.rawValue
        }
    case .opPlus, .opMinus, .opTime, .opDive:
        currentNum = numberToDecimal(&currentNumber)
        addOperationNode(currentNum, &operationText)
        
        var currentOp:CalcOperator = .plus
        switch key {
        case .opPlus:
            currentOp = .plus
        case .opMinus:
            currentOp = .minus
        case .opTime:
            currentOp = .times
        case .opDive:
            currentOp = .divide
        default:
            ()
        }
        
        currentOperator = currentOp
        operationText += " " +  currentOp.calcSymbol
        currentNum = 0
        currentNumber.removeAll()
    case .opEqual:
        currentNum = numberToDecimal(&currentNumber)
        currentNumber = showResult(currentNum, &operationText)
        currentNum = 0
    case .ac:
        if currentNum != 0 {
            currentNum = 0
            currentNumber.removeAll()
        } else {
            currentOperator = nil
            currentOperation = CalcOperation()
            operationText.removeAll()
            currentNumber.removeAll()
        }
    case .changeSign:
        if !currentNumber.isEmpty {
            currentNum = numberToDecimal(&currentNumber)
            currentNum *= (-1)
            currentNumber = "\(currentNum)"
        }
    case .percent:
        currentNum = numberToDecimal(&currentNumber)
        currentNum /= 100
        currentNumber = "\(currentNum)"
    }
}

func addOperationNode(_ currentNumber: Decimal, _ operationText: inout String) {
    if let currentOp = currentOperator {
        currentOperation.operationNode.append(CalcOperationNode(op: currentOp, operand: currentNum))
    } else {
        currentOperation.baseNumber = currentNum
    }
    operationText = currentOperation.operationString()
}

func numberToDecimal(_ stringNumber: inout String) -> Decimal {
    var checkstring = stringNumber
    if !checkstring.isEmpty {
        if checkstring.removeLast() == "." {
            stringNumber.removeLast()
        }
        if let doubleNumber = Double(stringNumber) {
            let number = Decimal(doubleNumber)
            return number
        }
    }
    return 0
}

func showResult (_ currentNum: Decimal, _ operationText: inout String) -> String {
    addOperationNode(currentNum, &operationText)
    operationText += " = "
    return "\(currentOperation.calcResult())"
}
