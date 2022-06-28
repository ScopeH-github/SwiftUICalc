import SwiftUI

public func calcButtonAction(key: CalcButtons, _ currentNumber: inout String, _ operationText: inout String) {
    switch key {
    case .zero, .doubleZero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
        currentNumber += key.rawValue
        operationText += key.rawValue
    case .floatPoint:
        if !currentNumber.contains(key.rawValue) {
            currentNumber += key.rawValue
            operationText += key.rawValue
        }
    case .opPlus, .opMinus, .opTime, .opDive:
        print(key.rawValue)
    case .opEqual:
        print(key.rawValue)
    case .ac:
        currentNumber.removeAll()
        operationText.removeAll()
    case .changeSign:
        print(key.rawValue)
    case .percent:
        print(key.rawValue)
    }
}
