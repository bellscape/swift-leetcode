import XCTest

// Generate Parentheses
class p22: XCTestCase {
    func testExample() throws {
        Judger.judge("p22", generateParenthesis)
    }


    // faster than 92%
    func generateParenthesis(_ n: Int) -> [String] {
        var out: [String] = []
        output(left: n, right: 0, out: &out, prefix: "")
        return out
    }
    private func output(left: Int, right: Int, out: inout [String], prefix: String) {
        if left <= 0 {
            out.append(prefix + String(repeating: ")", count: right))
        } else {
            output(left: left - 1, right: right + 1, out: &out, prefix: prefix + "(")
            if right > 0 {
                output(left: left, right: right - 1, out: &out, prefix: prefix + ")")
            }
        }
    }


    // faster than 11%
    func generateParenthesis_v1(_ n: Int) -> [String] {
        var out: [String] = []
        var cache: String = ""
        output_v1(left: n, right: 0, out: &out, cache: &cache)
        return out
    }
    private func output_v1(left: Int, right: Int, out: inout [String], cache: inout String) {
        if left <= 0 {
            for _ in 0..<right {
                cache.append(")")
            }
            out.append(cache)
            cache.removeLast(right)
        } else {
            cache.append("(")
            output_v1(left: left - 1, right: right + 1, out: &out, cache: &cache)
            cache.removeLast()
            if right > 0 {
                cache.append(")")
                output_v1(left: left, right: right - 1, out: &out, cache: &cache)
                cache.removeLast()
            }
        }
    }


}
