import XCTest

// Longest Substring Without Repeating Characters
class p3: XCTestCase {


    func lengthOfLongestSubstring(_ s: String) -> Int {
        var lastIndexDict = [Character: Int]()
        var firstSkipped = -1
        var maxLength = 0

        for (i, c) in s.enumerated() {
            if let lastIndex = lastIndexDict[c] {
                firstSkipped = max(firstSkipped, lastIndex)
            }
            lastIndexDict[c] = i
            maxLength = max(maxLength, i - firstSkipped)
        }
        return maxLength
    }


    func lengthOfLongestSubstring__v1(_ s: String) -> Int {
        var lastIndexDict = [Character: Int]()
        var from = 0
        var maxLength = 0

        let charArray = Array(s)
        for (i, c) in charArray.enumerated() {
            if let lastIndex = lastIndexDict[c], lastIndex >= from {
                from = lastIndex + 1
            }
            lastIndexDict[c] = i
            let len = i - from + 1
            if maxLength < len {
                maxLength = len
            }
        }
        return maxLength
    }


    func testExample() throws {
        Judger.judge("p3", lengthOfLongestSubstring)
    }

}
