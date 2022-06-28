// - MARK: CalcCore Test

var calc = Operation(
    base: 3, 
    operationNode: 
        [
            OperationNode(op: .plus, operand: 5), 
            OperationNode(op: .times, operand: 2)
        ]
)
let result = calc.mergeOpNodes()
