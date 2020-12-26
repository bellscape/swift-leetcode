import XCTest

class p13: XCTestCase {
    func testExample() throws {
        Judger.judge("p13", romanToInt)
    }


    // faster than 91%
    func romanToInt(_ s: String) -> Int {
        let dict: [Character: Int] = [
            "I": 1, "V": 5, "X": 10, "L": 50,
            "C": 100, "D": 500, "M": 1000]

        var out = 0
        var prev = 0
        var i = s.count - 1
        while i >= 0 {
            let base = dict[s[s.index(s.startIndex, offsetBy: i)]]!
            if base >= prev {
                out += base
            } else {
                out -= base
            }
            prev = base
            i -= 1
        }
        return out
    }


    // faster than 91%
    func romanToInt_v2(_ s: String) -> Int {
        var out = 0
        var last = 1000
        for c in s {
            let base = dict[c]!
            if last < base {
                out -= last * 2
            }
            out += base
            last = base
        }
        return out
    }
    /* static */ let dict: [Character: Int] = [
    "I": 1, "V": 5, "X": 10, "L": 50,
    "C": 100, "D": 500, "M": 1000]


    // faster than 79%, could be better
    func romanToInt_v1(_ s: String) -> Int {
        var out = 0
        var left = s
        var maxBaseI = bases.count - 1
        while !left.isEmpty {
            while !left.hasPrefix(symbols[maxBaseI]) {
                maxBaseI -= 1
            }
            out += bases[maxBaseI]
            left = String(left.dropFirst(symbols[maxBaseI].count))
        }
        return out
    }
    /* static */ let bases: [Int] = [1, 4, 5, 9, 10, 40, 50,
                                     90, 100, 400, 500, 900, 1000]
    /* static */ let symbols: [String] = ["I", "IV", "V", "IX", "X", "XL", "L",
                                          "XC", "C", "CD", "D", "CM", "M"]


}
