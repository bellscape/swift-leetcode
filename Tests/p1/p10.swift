import XCTest

class p10: XCTestCase {
    func testExample() throws {
        Judger.judge("p10", isMatch)
    }


    func isMatch(_ s: String, _ p: String) -> Bool {
        let chars: [Character] = Array(s)
        var cursor = [0]
        for token in Token.parse(p) {
            cursor = findNext(chars: chars, prevs: cursor, token: token)
        }
        return !cursor.isEmpty && cursor.last! == chars.count
    }
    func findNext(chars: [Character], prevs: [Int], token: Token) -> [Int] {
        guard !prevs.isEmpty else { return [] }
        let n = chars.count
        if token.varLen {
            if token.isAny() { // .*
                return Array(prevs.min()! ... n)
            } else { // a*
                var out: [Int] = []
                var i = -1
                for prev in prevs {
                    if prev <= i {
                        continue
                    }

                    i = prev
                    out.append(i)
                    while i < n && chars[i] == token.letter {
                        i += 1
                        out.append(i)
                    }
                }
                return out
            }
        } else {
            if token.isAny() {
                return prevs.filter { $0 < n }.map { $0 + 1 }
            } else {
                return prevs.filter { $0 < n && chars[$0] == token.letter }.map { $0 + 1 }
            }
        }
    }

    struct Token {
        let letter: Character
        let varLen: Bool
        func isAny() -> Bool { letter == "." }

        static func parse(_ p: String) -> [Token] {
            var tokens: [Token] = []
            var letter: Character?
            for c in p {
                if c == "*" {
                    assert(letter != nil)
                    tokens.append(Token(letter: letter!, varLen: true))
                    letter = nil
                } else {
                    if letter != nil {
                        tokens.append(Token(letter: letter!, varLen: false))
                    }
                    letter = c
                }
            }
            if letter != nil {
                tokens.append(Token(letter: letter!, varLen: false))
            }
            return tokens
        }
    }


}
