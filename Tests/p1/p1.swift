import XCTest

class p1: XCTestCase {

  class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
      var map = [Int: Int]()
      for (i2, num) in nums.enumerated() {
        if let i1 = map[num] {
          return [i1, i2]
        } else {
          map[target - num] = i2
        }
      }
      return []
    }
  }

  func testExample() throws {
    let x = Solution()
    XCTAssertEqual(x.twoSum([2,7,11,15], 9), [0,1])
    XCTAssertEqual(x.twoSum([3,2,4], 6), [1,2])
    XCTAssertEqual(x.twoSum([3,3], 6), [0,1])
  }

}
