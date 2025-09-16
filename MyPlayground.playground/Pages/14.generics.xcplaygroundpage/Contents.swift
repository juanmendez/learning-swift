//: [Previous](@previous)

import Foundation

func joinTwoElements<T>(a: T, b: T) -> String {
    return "\(a), \(b)"
}

print(joinTwoElements(a: 3, b: 3))

print(
    joinTwoElements(a: ["asdf"], b: ["ghlk"])
)

struct Stack<Element> {
    var elements: [Element] = []

    mutating func push(_ element: Element) {
        elements.append(element)
    }

    mutating func pop() -> Element? {
        return elements.popLast()
    }
}

extension Stack {
    var topItem: Element? {
        return if elements.isEmpty {
            nil
        } else {
            elements.last
        }
    }

    // how to make item be of type Equatable...
    func isTop(_ item: Element) -> Bool where Element: Equatable {
        guard let topItem = elements.last else {
            return false
        }
        return topItem == item
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("Hello")
stackOfStrings.push("World")
print("last element \(stackOfStrings.topItem ?? "no elements")")

// This is how Swift deals with type constraints.. for example let the type T be a subclass of SomeClass
// func someFunction<T: SomeClass>(someT: T) {...}

func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25, 9.3])
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcom", "Andrea"])

/**
 In Swift you cannot write a generic type for a protocol like in other C languages..

 protocol Container<Item> {
 var items: [T] { get set }
 mutating func addItem(_ item: T)
 }

 You can do this but instead be based on a Struct or Class
 struct Container<Item> {
 var items: [Item]

 mutating func addItem(_ item: Item) {
 items.append(item)
 }
 }

 but if you do want to use a protocol this is how you do it..
 */

protocol Container {
    associatedtype Item: Equatable
    func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

class StackContainer: Container {

    init(_ items: Int...) {
        items.forEach { item in
            append(item)
        }
    }

    private var items = [Int]()

    func append(_ item: Int) {
        items.append(item)
    }

    var count: Int {
        return items.count
    }

    subscript(i: Int) -> Int {
        return items[i]
    }
}

class StringContainer: Container {
    private var items: [String] = []

    func append(_ item: String) {
        items.append(item)
    }

    var count: Int {
        return items.count
    }

    subscript(i: Int) -> String {
        return items[i]
    }
}

var stackContainer = StackContainer()
stackContainer.append(1)
stackContainer.append(2)
stackContainer.append(3)
print(stackContainer.count)
print(stackContainer[1])

/**
 Quite nice we need a condition just to ensure both C1 and C2 not only are implementing Container,
 but both of them are of the same type in order to compare them if equal.
 */
func allItemsMatch<C1: Container, C2: Container>(
    _ someContainer: C1,
    _ anotherContainer: C2
) -> Bool where C1.Item: Equatable, C2.Item: Equatable, C1.Item == C2.Item {

    // Check that both containers contain the same number of items.
    if someContainer.count != anotherContainer.count {
        return false
    }

    // Check each pair of items to see if they're equivalent.
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }

    // All items match, so return true.
    return true
}

let a = StackContainer()
a.append(1)
let b = StackContainer()
b.append(1)

let result =
if allItemsMatch(a, b) {
    "items match"
} else {
    "items do not match"
}

print(result)

/**
 I also tried by only having in the condition the types match, as C1 and C2 items are of type Container, and there the item is already expected to be equatable.
 where C1.Item == C2.Item
 */
func allItemsMatchAsWell<C1: Container, C2: Container>(
    _ someContainer: C1,
    _ anotherContainer: C2
) -> Bool where C1.Item == C2.Item {

    // Check that both containers contain the same number of items.
    if someContainer.count != anotherContainer.count {
        return false
    }

    // Check each pair of items to see if they're equivalent.
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }

    // All items match, so return true.
    return true
}

print(allItemsMatchAsWell(a, b) ? "items match" : "items don't match")



/// The implementation of isTop(_:) uses the == operator, but the definition of Stack doesn’t require its items to be equatable, so using the == operator
/// results in a compile-time error. Using a generic where clause lets you add a new requirement to the extension, so that the extension adds the
/// isTop(_:) method only when the items in the stack are equatable.
extension Stack where Element: Equatable {
    func isBottom(_ item: Element) -> Bool {  // the where clause declared in the extension can also be set in here instead
        guard let bottomItem = elements.first else {
            return false
        }
        return bottomItem == item
    }
}

if stackOfStrings.isTop("tres") {
    print("top element is tres")
} else {
    print("Top element is something else")
}

extension Container {
    func average() -> Double where Item == Int {
        var sum = 0.0

        for index in 0..<count {
            sum += Double(self[index])
        }

        return sum / Double(count)
    }

    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count - 1] == item
    }

    subscript<Indices: Sequence>(indices: Indices) -> [Item] where Indices.Iterator.Element == Int {

        var result: [Item] = []
        for index in indices {
            result.append(self[index])
        }

        return result
    }
}

extension Container where Item == Int {
    func fancyMessage() -> String {
        "You are an amazing integer container"
    }
}

let numbers = StackContainer(1260, 1200, 98, 37)
print(numbers.average())
print(numbers[[0, 1]])
print(numbers.fancyMessage())


