import XCTest

class p11: XCTestCase {
    func testExample() throws {
        Judger.judge("p11", maxArea)
    }


    func maxArea(_ height: [Int]) -> Int {
        let n = height.count
        var leftI = 0
        var leftHeight = height[leftI]
        var rightI = n - 1
        var rightHeight = height[rightI]
        var leftLower = leftHeight < rightHeight

        var best = (leftLower ? leftHeight : rightHeight) * (rightI - leftI)

        global: while true {
            if leftLower {
                // move left
                while true {
                    leftI += 1
                    if leftI >= rightI { break global }
                    if height[leftI] > leftHeight { break }
                }
                leftHeight = height[leftI]
            } else {
                // move right
                while true {
                    rightI -= 1
                    if leftI >= rightI { break global }
                    if height[rightI] > rightHeight { break }
                }
                rightHeight = height[rightI]
            }
            leftLower = leftHeight < rightHeight
            best = max(best, (leftLower ? leftHeight : rightHeight) * (rightI - leftI))
        }
        return best
    }


    // timeout for large array
    func maxArea_v1(_ height: [Int]) -> Int {
        // find possible edges
        let n = height.count
        var lefts: [Int] = [0]
        var maxLeft = height[0]
        for i in 1..<n - 1 {
            if height[i] > maxLeft {
                lefts.append(i)
                maxLeft = height[i]
            }
        }
        var rights: [Int] = [n - 1]
        var maxRight = height[n - 1]
        for i in (1..<n - 1).reversed() {
            if height[i] > maxRight {
                rights.append(i)
                maxRight = height[i]
            }
        }

        // attempt on edges
        return lefts.map { left in
            let leftHeight = height[left]
            return rights.filter { $0 > left }
                .map { right in (right - left) * min(leftHeight, height[right]) }
                .max()!
        }.max()!
    }


}
