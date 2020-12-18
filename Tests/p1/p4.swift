import XCTest

// Median of Two Sorted Arrays
class p4: XCTestCase {

    func testExample() throws {
        Judger.judge("p4", findMedianSortedArrays)
    }

    // find i-th item
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let countTotal = nums1.count + nums2.count
        let needTwoNumber = countTotal % 2 == 0
        let iTotal = (countTotal - 1) / 2

        // assume: nums2[i2-1] <= nums1[i] <= nums2[i2]
        // find i1 while i1 + i2 = i0
        var i1From = max(0, iTotal - nums2.count)
        var i1Until = min(nums1.count, iTotal + 1)
        while i1From < i1Until {
            let i1 = (i1From + i1Until) / 2
            let i2 = iTotal - i1
            let x = nums1[i1]
            if i2 > 0 && nums2[i2 - 1] > x {
                i1From = i1 + 1
            } else if i2 < nums2.count && x > nums2[i2] {
                i1Until = i1
            } else {
                // found i1
                if needTwoNumber {
                    let y = i1 + 1 >= nums1.count ? nums2[i2]
                        : i2 >= nums2.count ? nums1[i1 + 1]
                        : min(nums1[i1 + 1], nums2[i2])
                    return Double(x + y) / 2.0
                } else {
                    return Double(x)
                }
            }
        }

        assert(i1From == i1Until)
        // assume: nums1[i1Until-1] <= nums2[i2] <= nums1[i1Until]
        let i2 = iTotal - i1Until
        let x = nums2[i2]
        if needTwoNumber {
            let y = i2 + 1 >= nums2.count ? nums1[i1Until]
                : i1Until >= nums1.count ? nums2[i2 + 1]
                : min(nums1[i1Until], nums2[i2 + 1])
            return Double(x + y) / 2.0
        } else {
            return Double(x)
        }
    }

    // faster than 6.06%, too slow
    func findMedianSortedArrays_v2(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var aFrom = 0, aUntil = nums1.count
        var bFrom = 0, bUntil = nums2.count
        assert(aUntil + bUntil >= 1)

        func calcMedian(_ x: Int, _ y: Int) -> Double { Double(x + y) / 2.0 }

        while true {
            // return b.median
            if aFrom >= aUntil {
                if (bUntil - bFrom) % 2 == 0 {
                    let i2 = (bFrom + bUntil) / 2
                    return calcMedian(nums2[i2 - 1], nums2[i2])
                } else {
                    let i = (bFrom + bUntil - 1) / 2
                    return Double(nums2[i])
                }
            }
            // return a.median
            if bFrom >= bUntil {
                if (aUntil - aFrom) % 2 == 0 {
                    let i2 = (aFrom + aUntil) / 2
                    return calcMedian(nums1[i2 - 1], nums1[i2])
                } else {
                    let i = (aFrom + aUntil - 1) / 2
                    return Double(nums1[i])
                }
            }
            // return median(a, b)
            if aUntil - aFrom + bUntil - bFrom <= 2 {
                return calcMedian(nums1[aFrom], nums2[bFrom])
            }

            // skip left
            if nums1[aFrom] < nums2[bFrom] {
                aFrom += 1
            } else {
                bFrom += 1
            }
            // skip right
            if nums1[aUntil - 1] >= nums2[bUntil - 1] {
                aUntil -= 1
            } else {
                bUntil -= 1
            }
        }
    }

    // faster than 8.08%, too slow
    func findMedianSortedArrays_v1(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var aFrom = 0, aUntil = nums1.count
        var bFrom = 0, bUntil = nums2.count
        func aCount() -> Int { aUntil - aFrom }
        func bCount() -> Int { bUntil - bFrom }
        assert(aCount() + bCount() >= 1)

        while aCount() + bCount() > 2 {
            // move left
            if aCount() <= 0 {
                bFrom += 1
            } else if bCount() <= 0 {
                aFrom += 1
            } else if nums1[aFrom] > nums2[bFrom] {
                bFrom += 1
            } else {
                aFrom += 1
            }

            // move right
            if aCount() <= 0 {
                bUntil -= 1
            } else if bCount() <= 0 {
                aUntil -= 1
            } else if nums1[aUntil - 1] < nums2[bUntil - 1] {
                bUntil -= 1
            } else {
                aUntil -= 1
            }
        }

        let left = aCount() <= 0 ? nums2[bFrom]
            : bCount() <= 0 ? nums1[aFrom]
            : min(nums1[aFrom], nums2[bFrom])
        let right = aCount() <= 0 ? nums2[bUntil - 1]
            : bCount() <= 0 ? nums1[aUntil - 1]
            : max(nums1[aUntil - 1], nums2[bUntil - 1])
        return (Double(left) + Double(right)) / 2
    }

}
