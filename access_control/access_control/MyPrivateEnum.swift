//
//  MyEnum.swift
//  access_control
//
//  Created by Mendez, Juan on 1/12/25.
//

// This enum was declared public, but once the cases deal with PrivateStruct, then enum class showed itself having an error.
// So I had to switch from public to private to compesate
private enum MyEnum {
    case case1(struct1: PrivateStruct)
    case case2(strinct2: PrivateStruct)
}

private struct PrivateStruct {
    let name: String
}

// likewise parameter foces method to be private or fileprivate
fileprivate func testMyEnum(_ privateStruct: PrivateStruct?) -> String? {
    return privateStruct?.name
}

// error.. function must be declared private or fileprivate because its result uses a private type
/**
 func whatIsTheCase() -> PrivateStruct {
    let juan =  PrivateStruct(name: "Juan")
    return juan
 }
 */


func whatIsTheCaseValue() -> String {
    let juan =  PrivateStruct(name: "Juan")
    return juan.name
}
