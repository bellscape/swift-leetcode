import XCTest

// 解析文本使用
public class TextParser {

    private let input: String
    private let end: String.Index
    private var cursor: String.Index

    public init(_ input: String) {
        self.input = input
        self.cursor = input.startIndex
        self.end = input.endIndex
    }

    func eof() -> Bool { cursor >= end }
    func peak() -> Character? { eof() ? nil : input[cursor] }
    func hasPrefix(_ prefix: String) -> Bool { input[cursor...].hasPrefix(prefix) }

    func next() { cursor = input.index(after: cursor) }
    func skipWhile(_ predicate: (Character) -> Bool) {
        while let c = peak(), predicate(c) {
            next()
        }
    }
    func skipWhitespace() { skipWhile { $0.isWhitespace } }
    func skipThisLine() {
        while let c = peak() {
            next()
            if c.isNewline {
                return
            }
        }
    }

    func skip(_ text: String) {
        assert(hasPrefix(text))
        cursor = input.index(cursor, offsetBy: text.count)
    }
    func readWhile(_ predicate: (Character) -> Bool) -> String {
        var chars: [Character] = []
        while let c = peak(), predicate(c) {
            chars.append(c)
            next()
        }
        return String(chars)
    }
    func readWord() -> String {
        let word = readWhile { $0.isLetter || $0.isNumber }
        return word
    }

}

class TextParserTest: XCTestCase {
    func testExample() throws {
        let parser = TextParser("(Array<Array<Int>>, Array<Int>, Int) -> Array<Int>")
        XCTAssertFalse(parser.eof())
        XCTAssertEqual(parser.peak(), "(")
        parser.skip("(")
        XCTAssertEqual(parser.peak(), "A")
        XCTAssertEqual(parser.readWord(), "Array")
        parser.skip("<")
        XCTAssertEqual(parser.readWord(), "Array")
        parser.skip("<")
        XCTAssertEqual(parser.readWord(), "Int")
        parser.skip(">>,")
        parser.skipWhitespace()
        XCTAssertEqual(parser.readWord(), "Array")

        XCTAssertFalse(parser.hasPrefix(" -> "))
        XCTAssertTrue(parser.hasPrefix("<Int>, Int) -> "))
        parser.skip("<Int>, Int) -> Array<Int>")
        XCTAssertTrue(parser.eof())
        XCTAssertNil(parser.peak())
    }
}
