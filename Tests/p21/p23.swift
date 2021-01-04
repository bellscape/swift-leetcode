import XCTest

// Merge k Sorted Lists
class p23: XCTestCase {
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { self.val = 0; self.next = nil; }
        public init(_ val: Int) { self.val = val; self.next = nil; }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    }


    // faster than 100%
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var arr: [Int] = []
        for list in lists {
            var cursor = list
            while let node = cursor {
                arr.append(node.val)
                cursor = node.next
            }
        }

        arr.sort(by: >)

        var head: ListNode? = nil
        for num in arr {
            head = ListNode(num, head)
        }
        return head
    }


    // faster than 85%
    func mergeKLists_v1(_ lists: [ListNode?]) -> ListNode? {
        mergeKLists_v1(lists, 0, lists.count)
    }
    func mergeKLists_v1(_ lists: [ListNode?], _ from: Int, _ until: Int) -> ListNode? {
        switch until - from {
        case 0: return nil
        case 1: return lists[from]
        case 2: return mergeTwoLists(lists[from], lists[from + 1])
        default:
            let leftUntil = (from + until) / 2
            return mergeTwoLists(mergeKLists_v1(lists, from, leftUntil), mergeKLists_v1(lists, leftUntil, until))
        }
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
