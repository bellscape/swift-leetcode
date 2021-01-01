import XCTest

// Valid Parentheses
class p20: XCTestCase {
    func testExample() throws {
        Judger.judge("p20", isValid)
    }


    func isValid(_ s: String) -> Bool {
        var stack: [Character] = []
        for c in s {
            switch c {
            case "(":
                stack.append(")")
            case "[":
                stack.append("]")
            case "{":
                stack.append("}")
            default:
                if let last = stack.last, last == c {
                    stack.remove(at: stack.count - 1)
                } else {
                    return false
                }
            }
        }
        return stack.isEmpty
    }


}
