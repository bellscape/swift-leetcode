import XCTest

// Swap Nodes in Pairs
class p24: XCTestCase {
    func testExample() throws {
        Judger.judge("p24", swapPairs)
    }


    func swapPairs(_ head: ListNode?) -> ListNode? {
        let dummy = ListNode(0, nil)
        var prev = dummy
        var cursor = head
        while let node = cursor {
            if let next = node.next {
                cursor = next.next
                prev.next = next
                next.next = node
                prev = node
            } else {
                cursor = nil
                prev.next = node
                prev = node
            }
        }
        prev.next = nil
        return dummy.next
    }


}
