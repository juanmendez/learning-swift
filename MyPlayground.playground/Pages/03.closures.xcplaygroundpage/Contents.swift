//: [Previous](@previous)
import Foundation

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

let backwardNames = names.sorted(by: backward)
print("backward names \(backwardNames)")

/**
 Closure Expression Syntax
 Closure expression syntax has the following general form:

 { (<#parameters#>) -> <#return type#>  in
 <#statements#>
 }


 {  param0, param2, paramN in return value}
 {param0, param2, parramN in returnValue }
 **/

let forwardClosure = { (s1: String, s2: String) -> Bool in
    return s1 > s2
}

let forwardNamesWithExplicitClosure = names.sorted(by: forwardClosure)

let forwardNamesWithImplicitClosures = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

let backwardNamesInferedClosure = names.sorted(by: { s1, s2 in return s1 > s2 })

let backwardNamesInferedClosureWithReturn = names.sorted(by: { s1, s2 in s1 > s2 })

// Shorthand Argument Names
let forwardNamesWithShortHandNames = names.sorted(by: { $0 > $1 })

let inferredParamsArgsAndReturnedValue = names.sorted(by: >)

let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine",
]
let numbers = [16, 58, 510]

let strings = numbers.map { number in
    var currentNumber = number
    var output = ""
    repeat {
        output = digitNames[currentNumber % 10]! + output
        currentNumber /= 10
    } while currentNumber > 0
    return output
}

func loadPicture(from server: String?, completion: (String) -> Void, onFailure: () -> Void) {
    if let picture = server {
        completion(picture)
    } else {
        onFailure()
    }
}

loadPicture(from: nil) {
    print("completed \($0)")
} onFailure: {
    print("Couldn't download the next picture.")
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    // completionHandlers.append(closure)
    // reads Converting non-escaping parameter 'closure' to generic parameter 'Element' may allow it to escape
    closure()
}

// escaping closure
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

var completionHandlers2: [() -> String] = []
func someFunctionWithEscapingAutoClosure(completionHandler: @escaping @autoclosure () -> String) {
    completionHandlers2.append(completionHandler)
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
        someFunctionWithEscapingAutoClosure(completionHandler: "hello")
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"

completionHandlers.first?()
print(instance.x)

print(completionHandlers2.first?())
