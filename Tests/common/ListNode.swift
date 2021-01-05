public class ListNode: Equatable, CustomStringConvertible {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }

    public static func ==(lhs: ListNode, rhs: ListNode) -> Bool {
        lhs.val == rhs.val && lhs.next == rhs.next
    }
    public var description: String {
        var out = "[\(val)"
        var tail = next
        while let nextNode = tail {
            out.append(",\(nextNode.val)")
            tail = nextNode.next
        }
        out.append("]")
        return out
    }
}
