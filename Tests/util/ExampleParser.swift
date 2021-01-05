import XCTest

class Example {
    var input: [Any] = []
    var output: Any?
}

extension TextParser {

    func skipParameterName() {
        if let c = peak(), c.isLetter {
            skipWhile { $0.isLetter || $0.isNumber }
            skipWhitespace()
            skip("=")
            skipWhitespace()
        }
    }
    func parseData(_ type: ParameterType) -> Any {
        switch type {
        case .int:
            let word = readWhile { $0.isNumber || $0 == "-" }
            return Int(word)!
        case .double:
            let word = readWhile { $0.isNumber || $0 == "." || $0 == "-" }
            return Double(word) ?? 0.0
        case .bool:
            let word = readWord()
            assert(word == "true" || word == "false")
            return word == "true"
        case .string:
            var chars: [Character] = []
            skip("\"")
            while let c = peak(), c != "\"" {
                chars.append(c)
                next()
            }
            skip("\"")
            return String(chars)
        case .optional(.listNode):
            let root = ListNode(0, nil)
            var last = root
            skip("[")
            skipWhitespace()
            while let c = peak(), c != "]" {
                if c == "," {
                    next()
                } else {
                    let node = ListNode(parseData(.int) as! Int, nil)
                    last.next = node
                    last = node
                }
                skipWhitespace()
            }
            skip("]")
            return root.next as Any
        case .array(let item):
            skip("[")
            skipWhitespace()
            var items: [Any] = []
            while let c = peak(), c != "]" {
                if c == "," {
                    next()
                } else {
                    items.append(parseData(item))
                }
                skipWhitespace()
            }
            skip("]")
            return items
        default:
            assert(false, "unknown type \(type)")
            return "unknown"
        }
    }
}

class ExampleParser {

    static func readAllExamples(_ problem: String, _ funcType: FuncType) -> [Example] {
        listFiles(problem)
            .flatMap { readFile($0, funcType) }
    }

    static func listFiles(_ problem: String) -> [URL] {
        let bundle = Bundle.init(for: ExampleParser.self)
        let allUrls: [URL] = bundle.urls(forResourcesWithExtension: "txt", subdirectory: nil) ?? []
        return allUrls.filter {
            $0.lastPathComponent.starts(with: problem + "-")
        }
    }

    static func readFile(_ url: URL, _ funcType: FuncType) -> [Example] {
        let filename = url.lastPathComponent
        if filename.contains("-example") {
            return readExampleFile(url, funcType)
        } else if filename.contains("-err") || filename.contains("-timeout") {
            return [readErrFile(url, funcType)]
        } else if filename.contains("-wa") {
            return [readWAFile(url, funcType)]
        } else {
            assert(false, "unknown file type \(filename)")
            return []
        }
    }

    static func readExampleFile(_ url: URL, _ funcType: FuncType) -> [Example] {
        let text: String = try! String(contentsOf: url, encoding: .utf8)
        let parser = TextParser(text)

        var examples: [Example] = []
        var lastExample: Example? = nil

        enum Mode {
            case beforeInput // --"Input:"--> input(0)
            case input(_ index: Int) // input(i) --read--> input(i+1)/beforeOutput
            case beforeOutput // --"Output:"--> output
            case output // --read--> beforeInput
        }
        var mode: Mode = .beforeInput

        parser.skipWhitespace()
        while !parser.eof() {
            switch mode {
            case .beforeInput:
                if parser.hasPrefix("Input:") {
                    parser.skip("Input:")
                    parser.skipWhitespace()
                    mode = .input(0)
                } else {
                    parser.skipThisLine()
                    parser.skipWhitespace()
                    lastExample = Example()
                }
            case .input(let index):
                parser.skipParameterName()
                let data = parser.parseData(funcType.params[index])
                parser.skipWhitespace()
                lastExample!.input.append(data)
                if index + 1 >= funcType.params.count {
                    mode = .beforeOutput
                } else {
                    mode = .input(index + 1)
                    parser.skip(",")
                    parser.skipWhitespace()
                }
            case .beforeOutput:
                parser.skip("Output:")
                parser.skipWhitespace()
                mode = .output
            case .output:
                let data = parser.parseData(funcType.output)
                lastExample?.output = data
                examples.append(lastExample!)
                lastExample = nil
                mode = .beforeInput
            }
        }
        return examples
    }

    static func readErrFile(_ url: URL, _ funcType: FuncType) -> Example {
        let text: String = try! String(contentsOf: url, encoding: .utf8)
        let parser = TextParser(text)

        let example = Example()
        for param in funcType.params {
            parser.skipWhitespace()
            example.input.append(parser.parseData(param))
        }
        return example
    }

    static func readWAFile(_ url: URL, _ funcType: FuncType) -> Example {
        let text: String = try! String(contentsOf: url, encoding: .utf8)
        let parser = TextParser(text)
        let example = Example()

        parser.skipWhitespace()
        parser.skip("Input:")
        for param in funcType.params {
            parser.skipWhitespace()
            example.input.append(parser.parseData(param))
        }

        while true {
            parser.skipWhitespace()
            if !parser.hasPrefix("Expected:") {
                parser.skipThisLine()
            } else {
                parser.skip("Expected:")
                parser.skipWhitespace()
                break
            }
        }
        example.output = parser.parseData(funcType.output)

        return example
    }

}

class ExampleParserTest: XCTestCase {

    func testListFiles() {
        let urls = ExampleParser.listFiles("p3")
        let url = urls.first { $0.lastPathComponent == "p3-example.txt" }!

        let p = p3()
        let funcType = FuncParser.parse(p.lengthOfLongestSubstring)
        let examples = ExampleParser.readExampleFile(url, funcType)
        XCTAssertEqual(examples.count, 4)
        print(examples)
    }

}
