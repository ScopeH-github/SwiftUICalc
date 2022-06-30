// - MARK: CalcCore Test

var calc = Operation(
    baseNumber: 3, 
    operationNode: 
        [
            OperationNode(op: .divide, operand: 5), 
            OperationNode(op: .plus, operand: 2),
            OperationNode(op: .times, operand: 7)
        ]
// 3 / 5 + 2 * 7
)
calc.mergePriorityNode()
let result = calc.mergeOpNodes()
