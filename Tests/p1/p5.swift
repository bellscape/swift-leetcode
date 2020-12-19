import XCTest

class p5: XCTestCase {
    func testExample() throws {
        Judger.judge("p5", longestPalindrome)
    }


    // optimized for same-char ranges
    func longestPalindrome(_ s: String) -> String {
        let chars: [Character] = Array(s)
        let n = chars.count
        var bestLeft = 0
        var bestLen = 1
        var coreFrom = 0
        while coreFrom < n {
            var left = coreFrom
            var right = coreFrom
            while right + 1 < n && chars[right + 1] == chars[left] {
                right += 1
            }
            coreFrom = right + 1
            while left > 0 && right + 1 < n && chars[left - 1] == chars[right + 1] {
                left -= 1
                right += 1
            }
            let len = right - left + 1
            if len > bestLen {
                bestLen = len
                bestLeft = left
            }
        }
        return String(chars[bestLeft..<bestLeft + bestLen])
    }


    // not optimized, faster than 20%
    func longestPalindrome_v1(_ s: String) -> String {
        let chars: [Character] = Array(s)
        let odd = longestOddPalindrome(chars)
        if let even = longestEvenPalindrome(chars), even.count > odd.count {
            return even
        } else {
            return odd
        }
    }
    func longestOddPalindrome(_ chars: [Character]) -> String {
        var result: String = String(chars[0])
        let n = chars.count

        var len = 1
        var matched: [Bool] = Array(repeating: true, count: n)
        while true {
            if let i = matched.firstIndex(where: { $0 }) {
                result = String(chars[i..<i + len])
            } else {
                break
            }

            len = len + 2
            if len > n {
                break
            }

            for i in 0...n - len {
                matched[i] = matched[i + 1] && chars[i] == chars[i + len - 1]
            }
            matched.removeLast(2)
        }
        return result
    }
    func longestEvenPalindrome(_ chars: [Character]) -> String? {
        var result: String?
        let n = chars.count
        guard n >= 2 else {
            return nil
        }

        var len = 2
        var matched: [Bool] = Array(0...n - len).map { i in chars[i] == chars[i + 1] }
        while true {
            if let i = matched.firstIndex(where: { $0 }) {
                result = String(chars[i..<i + len])
            } else {
                break
            }

            len = len + 2
            if len > n {
                break
            }

            for i in 0...n - len {
                matched[i] = matched[i + 1] && chars[i] == chars[i + len - 1]
            }
            matched.removeLast(2)
        }
        return result
    }

}
