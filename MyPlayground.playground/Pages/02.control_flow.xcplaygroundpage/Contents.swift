//: [Previous](@previous)

import Foundation

print("........ 1...5")
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

print("........ 1..<5")

for index in 1..<5 {
    print("\(index) times 5 is \(index * 5)")
}

print("........ stride(from:to:by:)")

for index in stride(from: 0, through: 5, by: 2) {
    print("\(index) times 5 is \(index * 5)")
}

print("........")

// Kotlin also enjoys using underscore to keep an argument anonymous
var answer = 1
for _ in 1..<5 {
    answer += answer
    print("answer \(answer)")
}

var limit = 10
var i = 0

print("........ while loop")
while i < limit {
    print("My limit is \(i)")
    i += 1
}

print("........ do-while loop")
repeat {
    print("My limit is \(i)")
    i += 1
} while i < limit

var month = 7

let season =
    switch month {
    case 1...3: "Winter"
    case 4...6: "Spring"
    case 7...9: "Summer"
    case 10...12: "Fall"
    default: "None"
    }

print("we are in \(season)")

// TURPLES!!!!!
let somePoint = ("key", "value")

switch somePoint {
case ("key", "value"): print("\(somePoint) matched!")
default: print("\(somePoint) not available")
}

switch somePoint {
case (let key, let value) where key.starts(with: "k"):
    print("\(somePoint) matched! with \(somePoint.0)")
default: print("\(somePoint) not available")
}

let EMPTY = ""
let puzzleInput = "Guns n' f*cking Roses"
var puzzleOutput = EMPTY
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " ", "*", "'"]

for character in puzzleInput {
    if charactersToRemove.contains(character) {
        // go as far as the next line and continue iteration
        continue
    }

    puzzleOutput.append(character)
}

print(puzzleOutput)
puzzleOutput = EMPTY

characterLabel: for character in puzzleInput {
    if charactersToRemove.contains(character) {
        // go as far as the next line and continue iteration
        break characterLabel
    }

    puzzleOutput.append(character)
}

print(puzzleOutput)

func a() {
    print("funky A")
    b()
}

func b() {
    print("funky B")
}

func funkyLetters() {
    defer {
        print("printed funky letters! at the end of method execution")
    }

    a()
    b()
}

funkyLetters()

func multipleValuesReturned() -> (a: String, b: Int, c: Int) {
    return ("a", 1, 2)
}

let valuesReturned = multipleValuesReturned()
print("values \(valuesReturned.a) \(valuesReturned.b) \(valuesReturned.c)")

func someFunction(argumentLabel parameterName: Int) -> Int {
    // In the function body, parameterName refers to the argument value
    // for that parameter.

    return parameterName * 2
}

someFunction(argumentLabel: 0)

func funcAsParam(myParam: Int, myFunc: (Int) -> Int) -> Int {
    return myFunc(myParam)
}

print("returned function \(funcAsParam(myParam: 1, myFunc: someFunction))")

func returnInteger() -> Int {
    return 1
}

func returnFunction() -> () -> Int {
    return returnInteger
}

print("return method \(returnFunction()())")
