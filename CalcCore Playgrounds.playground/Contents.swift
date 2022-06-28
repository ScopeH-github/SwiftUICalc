// - MARK: CalcCore Test

var calc = Operation(
    baseNumber: 3, 
    operationNode: 
        [
            OperationNode(op: .divide, operand: 5), 
            OperationNode(op: .plus, operand: 2)
        ]
// 3 / 5 + 2
)
calc.mergePriorityNode()
let result = calc.mergeOpNodes()
