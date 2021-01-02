import XCTest

// Merge Two Sorted Lists
class p21: XCTestCase {
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { self.val = 0; self.next = nil; }
        public init(_ val: Int) { self.val = val; self.next = nil; }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    }


    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard l1 != nil else { return l2 }
        guard l2 != nil else { return l1 }
        let node1 = l1!, node2 = l2!
        let takeFromL1 = node1.val <= node2.val
        let head = takeFromL1 ? node1 : node2
        let next1 = takeFromL1 ? node1.next : l1
        let next2 = takeFromL1 ? l2 : node2.next
        head.next = mergeTwoLists(next1, next2)
        return head
    }


}
