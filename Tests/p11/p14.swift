import XCTest

class p14: XCTestCase {
    func testExample() throws {
        Judger.judge("p14", longestCommonPrefix)
    }


    // faster than 26%
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard strs.count > 1 else {
            return strs.first ?? ""
        }

        let s0 = strs[0]
        let n = strs.count
        var common = s0.count

        for strI in 1..<n {
            let si = strs[strI]
            if si.count < common {
                common = si.count
            }
            for i in 0..<common {
                if s0[s0.index(s0.startIndex, offsetBy: i)] != si[si.index(si.startIndex, offsetBy: i)] {
                    common = i
                    break
                }
            }
        }

        return String(s0.prefix(common))
    }


    // faster than 81%
    func longestCommonPrefix_v1(_ strs: [String]) -> String {
        guard strs.count > 1 else {
            return strs.first ?? ""
        }

        let firstStr = strs[0]
        let n = strs.count
        let maxCount = strs.map { $0.count }.min()!
        var common = 0
        while common < maxCount {
            let idx = firstStr.index(firstStr.startIndex, offsetBy: common)
            let c = firstStr[idx]
            for i in 1..<n {
                if strs[i][idx] != c {
                    return String(firstStr.prefix(common))
                }
            }
            common += 1
        }
        return String(firstStr.prefix(maxCount))
    }


}
