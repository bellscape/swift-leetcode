import XCTest

// Divide Two Integers
class p29: XCTestCase {
    func testExample() throws {
        Judger.judge("p29", divide)
    }


    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        // -2^31 <= dividend, divisor <= 2^31 - 1
        // divisor != 0

        let negativeResult = (dividend >= 0) != (divisor > 0)

        var left = abs(dividend)

        var count = 1
        var num = abs(divisor)
        while true {
            let greaterNum = num << 1
            if greaterNum > left { break }
            num = greaterNum
            count <<= 1
        }

        var result = 0
        while true {
            if left >= num {
                left -= num
                result += count
            } else if count <= 1 {
                break
            } else {
                num >>= 1
                count >>= 1
            }
        }

        if negativeResult {
            result = -result
        }
        return result > Int32.max ? Int(Int32.max) : result
    }

}
