//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

/**
 Swift defines five distinct levels of access control: open, public, internal, fileprivate, and private.
 These levels determine the visibility of classes, structures, enumerations, methods, and other entities within our Swift code.
 */

private class PrivateClass {
    
    private(set) var name: String
    
    init(name: String) {
        self.name = name
    }
    
    open func openMethod() -> String {
        return name
    }
}

private let privateClass = PrivateClass(name: "Private")
print(privateClass.name)


