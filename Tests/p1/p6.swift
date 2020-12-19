import XCTest

class p6: XCTestCase {
    func testExample() throws {
        Judger.judge("p6", convert)
    }


    // faster than 98%
    func convert(_ s: String, _ numRows: Int) -> String {
        guard numRows > 1 else {
            return s
        }
        var output: [String] = Array(repeating: "", count: numRows)
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
        for i in 1..<numRows {
            output[0].append(output[i])
        }
        return output[0]
    }


    // better, faster than 83%
    func convert_v2(_ s: String, _ numRows: Int) -> String {
        guard numRows > 1 else {
            return s
        }
        var output: [String] = Array(repeating: "", count: numRows)
        let input: [Character] = Array(s)
        let n = input.count
        var i = 0
        loop: while true {
            // downwards
            for row in 0..<numRows {
                output[row].append(input[i])
                i += 1
                if i >= n {
                    break loop
                }
            }
            // upwards
            for row in stride(from: numRows - 2, through: 1, by: -1) {
                output[row].append(input[i])
                i += 1
                if i >= n {
                    break loop
                }
            }
        }
        for i in 1..<numRows {
            output[0].append(output[i])
        }
        return output[0]
    }


    // too slow, faster than 66%
    func convert_v1(_ s: String, _ numRows: Int) -> String {
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
