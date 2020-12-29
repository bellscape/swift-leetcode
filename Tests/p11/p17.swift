import XCTest

// Letter Combinations of a Phone Number
class p17: XCTestCase {
    func testExample() throws {
        Judger.judge("p17", letterCombinations)
    }


    func letterCombinations(_ digits: String) -> [String] {
        var out: [String] = []
        var cache: String = ""
        if !digits.isEmpty {
            iterate(digits, 0, &out, &cache)
        }
        return out
    }
    private func iterate(_ digits: String, _ i: Int, _ out: inout [String], _ cache: inout String) {
        let isLast = i + 1 == digits.count
        let digit = digits[digits.index(digits.startIndex, offsetBy: i)]
        for c in digitToChars[digit]! {
            cache.append(c)
            if isLast {
                out.append(cache)
            } else {
                iterate(digits, i + 1, &out, &cache)
            }
            cache.removeLast()
        }
    }
    let digitToChars: [Character: [Character]] = [
        "2": ["a", "b", "c"], "3": ["d", "e", "f"], "4": ["g", "h", "i"], "5": ["j", "k", "l"],
        "6": ["m", "n", "o"], "7": ["p", "q", "r", "s"], "8": ["t", "u", "v"], "9": ["w", "x", "y", "z"]
    ]

}
