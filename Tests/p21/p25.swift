import XCTest

// Reverse Nodes in k-Group
class p25: XCTestCase {
    func testExample() throws {
        Judger.judge("p25", reverseKGroup)
    }


    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard k > 1 else { return head }

        var cursor = head
        var count = 0
        while let node = cursor {
            count += 1
            cursor = node.next
        }

        let dummy = ListNode(0, nil)
        var blockPrev = dummy
        cursor = head
        while count >= k {
            let blockLast = cursor!
            var blockHead = blockLast
            cursor = blockHead.next

            for _ in 1..<k {
                let node = cursor!
                cursor = node.next
                node.next = blockHead
                blockHead = node
            }

            blockPrev.next = blockHead
            blockPrev = blockLast
            count -= k
        }

        blockPrev.next = cursor
        return dummy.next
    }


}
