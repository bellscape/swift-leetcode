import XCTest

// Letter Combinations of a Phone Number
class p18: XCTestCase {
    func testExample() throws {
        Judger.judge("p18", fourSum)
    }


    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        let n = nums.count
        guard n >= 4 else { return [] }
        let nums = nums.sorted()
        var out: [[Int]] = []
        for i1 in 0...n - 4 {
            let num1 = nums[i1]
            if i1 > 0 && num1 == nums[i1 - 1] { continue }
            let target234 = target - num1
            if target234 < 3 * nums[i1 + 1] || target234 > 3 * nums[n - 1] { continue }

            for i2 in i1 + 1...n - 3 {
                let num2 = nums[i2]
                if i2 > i1 + 1 && num2 == nums[i2 - 1] { continue }
                let target34 = target234 - num2
                if target34 < 2 * nums[i2 + 1] || target34 > 2 * nums[n - 1] { continue }

                var i3 = i2 + 1
                var i4 = n - 1
                var num3 = nums[i3]
                var num4 = nums[i4]
                each_i34: while true {
                    let diff = num3 + num4 - target34
                    if diff == 0 {
                        out.append([num1, num2, num3, num4])
                    }
                    if diff <= 0 {
                        while true {
                            i3 += 1
                            if i3 >= i4 { break each_i34 }
                            let num = nums[i3]
                            if num != num3 {
                                num3 = num
                                break
                            }
                        }
                    }
                    if diff >= 0 {
                        while true {
                            i4 -= 1
                            if i3 >= i4 { break each_i34 }
                            let num = nums[i4]
                            if num != num4 {
                                num4 = num
                                break
                            }
                        }
                    }
                }
            }
        }
        return out
    }


}
