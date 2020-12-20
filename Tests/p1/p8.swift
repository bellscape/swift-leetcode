import XCTest

class p8: XCTestCase {
    func testExample() throws {
        Judger.judge("p8", myAtoi)
    }


    func myAtoi(_ s: String) -> Int {
        var number: String = ""
        var expectDigits = false
        for c in s {
            if !expectDigits {
                if c.isWhitespace {
                    continue
                } else if c == "+" {
                    expectDigits = true
                    continue
                } else if c == "-" {
                    number.append(c)
                    expectDigits = true
                    continue
                } else if c.isNumber {
                    expectDigits = true
                }
            }
            if c.isNumber {
                number.append(c)
            } else {
                break
            }
        }
        return format(number)
    }
    private func format(_ s: String) -> Int {
        if let num = Int(s) {
            return num < Int32.min ? Int(Int32.min)
                : num > Int32.max ? Int(Int32.max)
                : num
        } else if s.hasPrefix("-") {
            return s.count <= 1 ? 0 : Int(Int32.min);
        } else {
            return s.isEmpty ? 0 : Int(Int32.max)
        }
    }

}
