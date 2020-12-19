import XCTest

class p6: XCTestCase {
    func testExample() throws {
        Judger.judge("p6", convert)
    }

    func convert(_ s: String, _ numRows: Int) -> String {
        guard numRows > 1 else {
            return s
        }
        var output: [[Character]] = Array(repeating: [], count: numRows)
        var row = 0
        var upwards = true
        for char in s {
            output[row].append(char)
            if row <= 0 {
                row = 1
                upwards = false
            } else if row >= numRows - 1 {
                row = numRows - 2
                upwards = true
            } else {
                row += upwards ? -1 : 1;
            }
        }
        return String(output.flatMap { $0 })
    }

}
