import XCTest

indirect enum ParameterType: Equatable {
    case int
    case string
    case arr(ParameterType)
}
typealias FuncType = (params: [ParameterType], output: ParameterType)

extension TextParser {
    func parseParameterType() -> ParameterType {
        let word = readWord()
        switch word {
        case "Int": return .int
        case "String": return .string
        case "Array":
            skip("<")
            let t = parseParameterType()
            skip(">")
            return .arr(t)
        default:
            assert(false)
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
        while true {
            inTypes.append(parser.parseParameterType())
            if let c = parser.peak(), c == ")" {
                break
            } else {
                parser.skip(", ")
            }
        }
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
        XCTAssertTrue(FuncParser.parse(f_3) == ([.arr(.arr(.int)), .arr(.int), .int], .arr(.int)))
        XCTAssertTrue(FuncParser.parse(f_2) == ([.arr(.int), .int], .int))
        XCTAssertTrue(FuncParser.parse(p.lengthOfLongestSubstring) == ([.string], .int))
        XCTAssertTrue(FuncParser.parse(f_1) == ([.int], .int))
    }

}
