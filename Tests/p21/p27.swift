// Remove Element
class p27 {


    // faster than 32%
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        nums = nums.filter { $0 != val }
        return nums.count
    }


    // faster than 32%
    func removeElement_v2(_ nums: inout [Int], _ val: Int) -> Int {
        nums.removeAll { $0 == val }
        return nums.count
    }


    // faster than 32%
    func removeElement_v1(_ nums: inout [Int], _ val: Int) -> Int {
        let n = nums.count
        guard n > 0 else { return 0 }

        var size = 0
        while size < n && nums[size] != val {
            size += 1
        }
        guard n > size else { return size }

        for num in nums[size + 1 ..< n] {
            if num != val {
                nums[size] = num
                size += 1
            }
        }
        return size
    }


}
