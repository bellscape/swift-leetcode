import XCTest

indirect enum JType: Equatable {
    case int
    case string
    case arr(JType)
}

extension TextParser {
    func parseType() -> JType {
        let word = readWord()
        switch word {
        case "Int": return .int
        case "String": return .string
        case "Array":
            skip("<")
            let t = parseType()
            skip(">")
            return .arr(t)
        default:
            assert(false)
        }
    }
}

struct Reflector {

    // parse function declaration
    static func parse(_ f: Any) -> ([JType], JType) {
        // (Int) -> Int
        // (Array<Int>, Int) -> Int
        // (Array<Array<Int>>, Array<Int>, Int) -> Array<Int>
        let parser = TextParser("\(type(of: f))")

        var inTypes: [JType] = []
        parser.skip("(")
        while true {
            inTypes.append(parser.parseType())
            if let c = parser.peak(), c == ")" {
                break
            } else {
                parser.skip(", ")
            }
        }
        parser.skip(") -> ")
        let outType = parser.parseType()
        assert(parser.isEof())
        return (inTypes, outType)
    }

}

class ReflectorTest: XCTestCase {

    func f_1(x: Int) -> Int { x + 1 }
    func f_2(x: [Int], y: Int) -> Int { x.reduce(0, +) + y }
    func f_3(x: [[Int]], y: [Int], z: Int) -> [Int] { [0] }

    func testExample() throws {
        let p = p3()
        XCTAssertTrue(Reflector.parse(f_3) == ([.arr(.arr(.int)), .arr(.int), .int], .arr(.int)))
        XCTAssertTrue(Reflector.parse(f_2) == ([.arr(.int), .int], .int))
        XCTAssertTrue(Reflector.parse(p.lengthOfLongestSubstring) == ([.string], .int))
        XCTAssertTrue(Reflector.parse(f_1) == ([.int], .int))
    }

}
