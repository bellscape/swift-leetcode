import XCTest

class p2: XCTestCase {

  public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
  }

  func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    addTwoNumbers(carry: 0, l1, l2)
  }
  func addTwoNumbers(carry: Int, _ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    if carry == 0 && l1 == nil && l2 == nil {
      return nil
    } else {
      let num = carry + (l1?.val ?? 0) + (l2?.val ?? 0)
      return ListNode(num % 10, addTwoNumbers(carry: num / 10, l1?.next, l2?.next))
    }
  }

  func testExample() throws {
    XCTAssertEqual(dumpNumber(addTwoNumbers(buildNumber([2,4,3]), buildNumber([5,6,4]))),
                   dumpNumber(buildNumber([7,0,8])))
    XCTAssertEqual(dumpNumber(addTwoNumbers(buildNumber([0]), buildNumber([0]))),
                   dumpNumber(buildNumber([0])))
    XCTAssertEqual(dumpNumber(addTwoNumbers(buildNumber([9,9,9,9,9,9,9]), buildNumber([9,9,9,9]))),
                   dumpNumber(buildNumber([8,9,9,9,0,0,0,1])))
  }
  func buildNumber(_ digits: [Int]) -> ListNode? {
    if digits.count <= 0 {
      return nil
    } else {
      return ListNode(digits[0], buildNumber(Array(digits[1 ..< digits.count])))
    }
  }
  func dumpNumber(_ list: ListNode?) -> String {
    if let node = list {
      return String(node.val) + "," + dumpNumber(node.next)
    } else {
      return ""
    }
  }

}
