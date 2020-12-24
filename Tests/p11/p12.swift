import XCTest

class p12: XCTestCase {
    func testExample() throws {
        Judger.judge("p12", intToRoman)
    }


    // faster than 73%
    func intToRoman(_ num: Int) -> String {
        M[num / 1000] + C[(num % 1000) / 100] + X[(num % 100) / 10] + I[num % 10]
    }
    /* static */ let M: [String] = ["", "M", "MM", "MMM"]
    /* static */ let C: [String] = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]
    /* static */ let X: [String] = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
    /* static */ let I: [String] = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]


    // faster than 53%
    func intToRoman_v1(_ num: Int) -> String {
        var out = ""
        var left = num
        var baseI = bases.count - 1
        while left > 0 {
            let base = bases[baseI]
            if base > left {
                baseI -= 1
            } else {
                left -= base
                out += symbols[baseI]
            }
        }
        return out
    }
    /* static */ let bases: [Int] = [1, 4, 5, 9, 10, 40, 50,
                                     90, 100, 400, 500, 900, 1000]
    /* static */ let symbols: [String] = ["I", "IV", "V", "IX", "X", "XL", "L",
                                          "XC", "C", "CD", "D", "CM", "M"]


}
