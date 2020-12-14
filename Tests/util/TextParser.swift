import XCTest

// 解析文本使用
public class TextParser {

    private let input: String
    private let eof: String.Index
    private var cursor: String.Index

    public init(_ input: String) {
        self.input = input
        self.cursor = input.startIndex
        self.eof = input.endIndex
    }

    func isEof() -> Bool { cursor >= eof }
    func peak() -> Character? { return isEof() ? nil : input[cursor] }

    func skipBlanks() {
        while let c = peak(), c.isWhitespace {
            cursor = input.index(after: cursor)
        }
    }
    func skip(_ text: String) {
        assert(input[cursor...].hasPrefix(text))
        cursor = input.index(cursor, offsetBy: text.count)
    }
    func readWord() -> String {
        var chars: [Character] = []
        while let c = peak(), (c.isLetter || c.isNumber) {
            chars.append(c)
            cursor = input.index(after: cursor)
        }
        assert(!chars.isEmpty)
        return String(chars)
    }

}

class TextParserTest: XCTestCase {
    func testExample() throws {
        let parser = TextParser("(Array<Array<Int>>, Array<Int>, Int) -> Array<Int>")
        XCTAssertFalse(parser.isEof())
        XCTAssertEqual(parser.peak(), "(")
        parser.skip("(")
        XCTAssertEqual(parser.peak(), "A")
        XCTAssertEqual(parser.readWord(), "Array")
        parser.skip("<")
        XCTAssertEqual(parser.readWord(), "Array")
        parser.skip("<")
        XCTAssertEqual(parser.readWord(), "Int")
        parser.skip(">>,")
        parser.skipBlanks()
        XCTAssertEqual(parser.readWord(), "Array")
        parser.skip("<Int>, Int) -> Array<Int>")
        XCTAssertTrue(parser.isEof())
        XCTAssertNil(parser.peak())
    }
}
