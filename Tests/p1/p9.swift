import XCTest

class p9: XCTestCase {
    func testExample() throws {
        Judger.judge("p9", isPalindrome)
    }


    // faster than 89%
    func isPalindrome(_ x: Int) -> Bool {
        var left = x, reversed = 0
        while left > 0 {
            reversed = reversed * 10 + left % 10
            left /= 10
        }
        return x == reversed
    }


    // faster than 68%
    func isPalindrome_v3(_ x: Int) -> Bool {
        guard x >= 0 else { return false }
        var left = x, reversed = 0
        while left != 0 {
            reversed = reversed * 10 + left % 10
            left /= 10
        }
        return x == reversed
    }


    // faster than 48%
    func isPalindrome_v2(_ x: Int) -> Bool {
        guard x >= 0 else { return false }
        var left = x, reversed = 0
        while left != 0 {
            let remainder: Int
            (left, remainder) = left.quotientAndRemainder(dividingBy: 10)
            reversed = reversed * 10 + remainder
        }
        return x == reversed
    }


    // too slow, faster than 13%
    func isPalindrome_v1(_ x: Int) -> Bool {
        if x >= 0, let y = Int(String(String(x).reversed())), x == y {
            return true
        } else {
            return false
        }
    }


}
