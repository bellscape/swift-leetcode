import XCTest

extension Example {
    func call<I, O>(_ function: (I) -> O) -> O {
        switch input.count {
        case 1:
            return function(input[0] as! I)
        case 2:
            return function((input[0], input[1]) as! I)
        case 3:
            return function((input[0], input[1], input[2]) as! I)
        case 4:
            return function((input[0], input[1], input[2], input[3]) as! I)
        default:
            return "" as! O
        }
    }
}

struct Judger {

    static func judge<I, O>(_ problem: String, _ function: (I) -> O) where O: Equatable {
        let funcType = FuncParser.parse(function)
        let examples = ExampleParser.readAllExamples(problem, funcType)
        for (i, example) in examples.enumerated() {
            print()
            print("Example \(i + 1):")
            print("Input: \(example.input)")
            let startTime = Date()
            let actual = example.call(function)
            let cost = Int(-startTime.timeIntervalSinceNow * 1000)
            print("Output actual: \(actual)")
            print("Exec cost: \(cost) ms")
            if let output = example.output {
                print("Output expected: \(output)")
                XCTAssertEqual(actual, output as! O)
            }
        }
        print()
        print("\(examples.count) Examples Tested for \(problem)")
        print()
    }

}
