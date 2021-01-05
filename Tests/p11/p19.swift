import XCTest

// Remove Nth Node From End of List
class p19: XCTestCase {
    func testExample() throws {
        Judger.judge("p19", removeNthFromEnd)
    }


    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        // case list.count == n: return head.next
        var tail = head!
        for _ in 0..<n - 1 {
            tail = tail.next!
        }
        if tail.next == nil {
            return head?.next
        }

        // case node.count > n: remove (list.count - n - 1).next
        var prev = head!
        tail = tail.next!
        while tail.next != nil {
            prev = prev.next!
            tail = tail.next!
        }
        prev.next = prev.next?.next
        return head
    }


}
