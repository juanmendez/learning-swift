// The Swift Programming Language
// https://docs.swift.org/swift-book
 
// ths is the least restrictive access and designed specially for modules...
open class Welcome {
    // here the getter is public but the setter is private
    public private(set) var greeting: String = accessLevelHereIsPrivateFile()
    
    // the default access level is internal. that works well when writing code which is sealed inside this module
    // but from the outside we need to set the access level which in this case public works.. not open
    public init() {
        accessLevelHereIsInternal()
    }
}

// this function cannot be access anywhere within this module except in this file.
fileprivate func accessLevelHereIsPrivateFile() -> String {
    return "Welcome to the library"
}
