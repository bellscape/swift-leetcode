import XCTest

class p7: XCTestCase {
    func testExample() throws {
        Judger.judge("p7", reverse)
    }


    func reverse(_ x: Int) -> Int {
        var left = x
        var out = 0
        while left != 0 {
            out = out * 10 + left % 10
            left /= 10
        }
        return out > Int32.max || out < Int32.min ? 0 : out
    }


    // no need to consider negative number separately
    func reverse_v1(_ x: Int) -> Int {
        guard x >= 0 else {
            return -reverse(-x)
        }

        var left = x
        var out = 0
        while left > 0 {
            out = out * 10 + left % 10
            left /= 10
        }
        return out > Int32.max ? 0 : out
    }


}
