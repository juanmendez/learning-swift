//: [Previous](@previous)

import Foundation

//: [Next](@next)


protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    func draw() -> String {
        var result: [String] = []
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}

struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        if shape is Square {
            return shape.draw()
        }
        
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}

struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}

struct Square: Shape {
    var size: Int
    func draw() -> String {
        let line = String(repeating: "*", count: size)
        let result = Array<String>(repeating: line, count: size)
        return result.joined(separator: "\n")
    }
}


// Opaque type returned
func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 2)
    let middle = Square(size: 2)
    let bottom = FlippedShape(shape: top)
    let trapezoid = JoinedShape(
        top: top,
        bottom: JoinedShape(top: middle, bottom: bottom)
    )
    return trapezoid
}

// Opaque type returned
func flip<T: Shape>(_ shape: T) -> some Shape {
    return FlippedShape(shape: shape)
}

// Opaque type returned
func join<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> some Shape {
    JoinedShape(top: top, bottom: bottom)
}

// Opaque type returned
func invalidFlip<T: Shape>(_ shape: T) -> some Shape {
    return FlippedShape(shape: shape) // Error: return types don't match
}


// Box protocol types
struct VerticalShapes: Shape {
    var shapes: [any Shape]
    func draw() -> String {
        return shapes.map { $0.draw() }.joined(separator: "\n\n")
    }
}

let largeTriangle = Triangle(size: 5)
let largeSquare = Square(size: 5)
let joinedShape = JoinedShape(top: largeSquare, bottom: largeTriangle)
let vertical = VerticalShapes(shapes: [largeTriangle, largeSquare, joinedShape])
print(vertical.draw())


protocol Shape1 {
    func area() -> Double
}

struct Circle: Shape1 {
    var radius: Double
    func area() -> Double {
        return .pi * radius * radius
    }
}

struct Square1: Shape1 {
    var side: Double
    func area() -> Double {
        return side * side
    }
}

// Function returning an opaque type
func makeShape() -> some Shape1 {
    return Circle(radius: 5)
}

func makeShape2() -> Shape1 {
    return Circle(radius: 5)
}

let shape = makeShape()
let shape2 = makeShape2()
print(shape)
print(shape.area())  // Output: 78.53981633974483
