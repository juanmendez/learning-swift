//: [Previous](@previous)

import Foundation

class SomeClass {
    static var name = ""
    
    // the advantage of class type method is self as reference to the class itself
    class func someTypeMethod() {
        self.name = "hello"
    }
}

class SomeSubclass: SomeClass {
    
    override class func someTypeMethod() {
        self.name = "nom"
    }
}


SomeSubclass.someTypeMethod()
print(SomeClass.name)

/**
 What it is interesting about static func vs class func is the fact that a static method cannot be overriden, and can apply to struct, class, and enums.

 */

protocol IdentifiableType {
    static func typeName() -> String
}

class Animal: IdentifiableType {
    // if instead we use a static method, then Dog cannot override it.
    class func typeName() -> String {
        return "Animal"
    }
}

class Dog: Animal {
    override class func typeName() -> String {
        return "Dog"
    }
}

