import XCTest

// Implement strStr()
class p28: XCTestCase {
    func testExample() throws {
        Judger.judge("p28", strStr)
    }


    // faster than 18%
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.isEmpty { return 0 }
        if needle.count > haystack.count { return -1 }

        let pattern = try! NSRegularExpression(pattern: needle)
        if let m = pattern.firstMatch(in: haystack, options: [], range: NSRange(location: 0, length: haystack.count)) {
            return m.range.lowerBound
        } else {
            return -1
        }
    }


    // timeout
    func strStr_v1(_ haystack: String, _ needle: String) -> Int {
        if needle.isEmpty { return 0 }
        if needle.count > haystack.count { return -1 }

        if let range = haystack.range(of: needle) {
            return haystack.distance(from: haystack.startIndex, to: range.lowerBound)
        } else {
            return -1
        }
    }


}
