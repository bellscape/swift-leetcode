import XCTest

// 3Sum Closest
class p16: XCTestCase {
    func testExample() throws {
        Judger.judge("p16", threeSumClosest)
    }


    // faster than 97%
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        let nums = nums.sorted()
        let n = nums.count
        // target = num1 + num2 + num3 + miss
        var bestMiss = target - nums[0] - nums[1] - nums[n - 1]
        var bestDiff = abs(bestMiss)
        for i1 in 0...n - 3 {
            let num1 = nums[i1]
            let target23 = target - num1

            var i2 = i1 + 1
            var i3 = n - 1
            while i2 < i3 {
                let miss = target23 - nums[i2] - nums[i3]
                if miss == 0 {
                    return target
                } else if miss > 0 {
                    i2 += 1
                } else {
                    i3 -= 1
                }
                let diff = abs(miss)
                if diff < bestDiff {
                    bestMiss = miss
                    bestDiff = diff
                }
            }
        }
        return target - bestMiss
    }


}
