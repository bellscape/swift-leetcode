import XCTest

// Remove Duplicates from Sorted Array
class p26: XCTestCase {


    func removeDuplicates(_ nums: inout [Int]) -> Int {
        let n = nums.count
        guard n > 1 else { return n }

        var last = nums[0]
        var nonDuplicateCount = 1

        // skip non duplicate zones
        while nonDuplicateCount < n {
            let num = nums[nonDuplicateCount]
            if num > last {
                last = num
                nonDuplicateCount += 1
            } else {
                break
            }
        }

        // move non-duplicate values
        guard n > nonDuplicateCount else { return nonDuplicateCount }
        for num in nums[(nonDuplicateCount + 1)..<n] {
            if num > last {
                last = num
                nums[nonDuplicateCount] = last
                nonDuplicateCount += 1
            }
        }

        nums.removeLast(n - nonDuplicateCount)
        return nonDuplicateCount
    }


}
