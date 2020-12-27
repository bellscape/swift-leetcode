import XCTest

// 3Sum
class p15: XCTestCase {
    func testExample() throws {
        Judger.judge("p15", threeSum)
    }


    // faster than 99%
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let n = nums.count
        guard n >= 3 else { return [] }
        let nums = nums.sorted()
        var out: [[Int]] = []

        var num1 = 1
        for i1 in 0...n - 3 {
            if nums[i1] == num1 { continue }
            num1 = nums[i1]
            if num1 > 0 { break }

            var i2 = i1 + 1, i3 = n - 1
            var num2 = nums[i2], num3 = nums[i3]
            each_i1: while i2 < i3 {
                let sum = num1 + num2 + num3
                if (sum == 0) {
                    out.append([num1, num2, num3])
                }

                if sum <= 0 {
                    while true {
                        i2 += 1
                        if i2 >= i3 {
                            break each_i1
                        }
                        let nextNum2 = nums[i2]
                        if num2 != nextNum2 {
                            num2 = nextNum2
                            break
                        }
                    }
                }
                if sum >= 0 {
                    while true {
                        i3 -= 1
                        if i2 >= i3 {
                            break each_i1
                        }
                        let nextNum3 = nums[i3]
                        if num3 != nextNum3 {
                            num3 = nextNum3
                            break
                        }
                    }
                }
            }
        }
        return out
    }


    // faster than 46%
    func threeSum_v2(_ nums: [Int]) -> [[Int]] {
        let n = nums.count
        guard n >= 3 else { return [] }
        let nums = nums.sorted()
        var out: [[Int]] = []

        var num1 = 1
        for i1 in 0...n - 3 {
            if nums[i1] == num1 {
                continue
            }
            num1 = nums[i1]
            if num1 > 0 { break }

            var i2 = i1 + 1, i3 = n - 1
            var num2 = nums[i2], num3 = nums[i3]

            each_i1: while i2 < i3 {
                let sum = num1 + num2 + num3
                if (sum == 0) {
                    out.append([num1, num2, num3])
                }

                if sum <= 0 {
                    while true {
                        i2 += 1
                        if i2 > n - 2 {
                            break each_i1
                        }
                        let nextNum2 = nums[i2]
                        if num2 != nextNum2 {
                            num2 = nextNum2
                            break
                        }
                    }
                }
                if sum >= 0 {
                    while true {
                        i3 -= 1
                        if i3 < 2 {
                            break each_i1
                        }
                        let nextNum3 = nums[i3]
                        if num3 != nextNum3 {
                            num3 = nextNum3
                            break
                        }
                    }
                }
            }
        }
        return out
    }


    // faster than 35%
    func threeSum_v1(_ nums: [Int]) -> [[Int]] {
        let n = nums.count
        guard n >= 3 else { return [] }
        let sorted = nums.sorted()
        var out: [[Int]] = []

        var num1 = sorted.first! - 1
        var num2 = sorted.first! - 2
        for i1 in 0...n - 3 {
            if sorted[i1] == num1 {
                continue
            }
            num1 = sorted[i1]

            for i2 in i1 + 1...n - 2 {
                if sorted[i2] == num2 {
                    continue
                }
                num2 = sorted[i2]

                let num3 = -num1 - num2
                if contains(sorted, num3, from: i2 + 1) {
                    out.append([num1, num2, num3])
                }
            }
        }
        return out
    }
    private func contains(_ sorted: [Int], _ num: Int, from: Int) -> Bool {
        guard sorted[from] <= num && num <= sorted.last! else { return false }

        var left = from, right = sorted.count - 1
        while true {
            let mid = (left + right) / 2
            let midNum = sorted[mid]
            if midNum == num {
                return true
            } else if midNum < num {
                left = mid + 1
            } else {
                right = mid - 1
            }
            if left > right {
                return false
            }
        }
    }

}

