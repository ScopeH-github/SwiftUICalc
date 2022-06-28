import SwiftUI

public enum CalcButtons: String {
    case ac = "AC", changeSign = "+/-", percent = "%"
    case zero = "0", doubleZero = "00", one = "1", two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9"
    case floatPoint = "."
    case opDive = "÷", opTime = "×", opMinus = "-", opPlus = "+", opEqual = "="
}

let buttonArray: [[CalcButtons]] = [
    [.ac, .changeSign, .percent, .opDive],
    [.seven, .eight, .nine, .opTime],
    [.four, .five, .six, .opMinus],
    [.one, .two, .three, .opPlus],
    [.zero, .doubleZero, .floatPoint, .opEqual]
]

struct CalcView: View {
    @State var currentNumber: String = ""
    @State var operationText: String = ""
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                HStack {
                    Text(operationText)
                        .font(.custom("Menlo", size: 20))
                        .foregroundColor(.gray)
                        .monospacedDigit()
                    Spacer()
                }.padding()
                HStack {
                    Spacer()
                    Text(currentNumber.isEmpty ? "0" : currentNumber)
                        .font(.system(.largeTitle))
                        .foregroundColor(.white)
                }.padding()
                ForEach(buttonArray, id: \.self) { row in
                    HStack {
                        ForEach (row, id: \.self) { key in
                            Button(action: { calcButtonAction(key: key, &currentNumber, &operationText) }) {
                                Text(key.rawValue)
                                    .font(.system(size: 40))
                                    .frame(width: 80, height: 85, alignment: .center)
                                    .foregroundColor(buttonTextColor(key: key))
                            }
                            .buttonStyle(.borderedProminent)
                            .accentColor(buttonColor(key: key))
                        }
                    }
                }
            }
        }
    }
    
    func buttonColor(key: CalcButtons) -> Color {
        switch key {
        case .opEqual, .opPlus, .opMinus, .opTime, .opDive:
            return .orange
        case .ac, .changeSign, .percent:
            return .secondary
        default:
            return .secondary.opacity(30/100)
        }
    }
    func buttonTextColor(key: CalcButtons) -> Color {
        switch key {
        case .opEqual, .opPlus, .opMinus, .opTime, .opDive:
            return .white
        case .ac, .changeSign, .percent:
            return .black
        default:
            return .white
        }
    }
}
