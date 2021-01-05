import XCTest

indirect enum ParameterType: Equatable {
    case int
    case double
    case bool
    case string
    case array(ParameterType)
    case optional(ParameterType)
    case listNode
}
typealias FuncType = (params: [ParameterType], output: ParameterType)

extension TextParser {
    func parseParameterType() -> ParameterType {
        let word = readWord()
        switch word {
        case "Int": return .int
        case "Double": return .double
        case "String": return .string
        case "Bool": return .bool
        case "Array":
            skip("<")
            let t = parseParameterType()
            skip(">")
            return .array(t)
        case "Optional":
            skip("<")
            let t = parseParameterType()
            skip(">")
            return .optional(t)
        case "ListNode":
            return .listNode
        default:
            assert(false, "unknown type \(word)")
        }
    }
}

struct FuncParser {

    // parse function declaration
    static func parse<I, O>(_ function: (I) -> O) -> FuncType {
        let dump = "\(type(of: function))"
        return parse(dump: dump)
    }
    static func parse(dump: String) -> FuncType {
        // (Int) -> Int
        // (Array<Int>, Int) -> Int
        // (Array<Array<Int>>, Array<Int>, Int) -> Array<Int>
        let parser = TextParser(dump)

        var inTypes: [ParameterType] = []
        parser.skip("(")

        var hasTuple = false
        if let c = parser.peak(), c == "(" {
            hasTuple = true
            parser.next()
        }

        while true {
            inTypes.append(parser.parseParameterType())
            if let c = parser.peak(), c == ")" {
                break
            } else {
                parser.skip(", ")
            }
        }

        if hasTuple { parser.skip(")") }
        parser.skip(") -> ")
        let outType = parser.parseParameterType()
        assert(parser.eof())
        return (inTypes, outType)
    }

}

class FuncParserTest: XCTestCase {

    func f_1(x: Int) -> Int { x + 1 }
    func f_2(x: [Int], y: Int) -> Int { x.reduce(0, +) + y }
    func f_3(x: [[Int]], y: [Int], z: Int) -> [Int] { [0] }

    func testExample() throws {
        let p = p3()
        XCTAssertTrue(FuncParser.parse(f_3) == ([.array(.array(.int)), .array(.int), .int], .array(.int)))
        XCTAssertTrue(FuncParser.parse(f_2) == ([.array(.int), .int], .int))
        XCTAssertTrue(FuncParser.parse(p.lengthOfLongestSubstring) == ([.string], .int))
        XCTAssertTrue(FuncParser.parse(f_1) == ([.int], .int))
    }

}
