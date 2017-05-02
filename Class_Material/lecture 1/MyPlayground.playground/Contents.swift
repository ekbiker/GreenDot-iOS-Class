//: Playground - noun: a place where people can play

import UIKit
import Foundation

//protocol
protocol SomeBaseProtocol {
    var storage: String? { get }
    var protocolName: String { get }
    static func printMyName()
}
extension SomeBaseProtocol {
    static func printMyName() {
        print("my name")
    }
    var storage: String? {
        return nil
    }
}

protocol AnotherProtocol: Hashable, Equatable {
    
}


//enum
enum SomeBaseEnum: SomeBaseProtocol {
    var protocolName: String {return "my Name Is"}
    var storage: String? { return "storage" }
//    static func printMyName() {
//        print("SomeBaseEnum")
//    }
}

extension SomeBaseEnum {
    
}



//metatypes
class SomeBaseClass {
    class func printClassName() {
        print("SomeBaseClass")
    }
    deinit {
        print("SomeBaseClass deinited")
    }
}
class SomeSubClass: SomeBaseClass {
    override class func printClassName() {
        print("SomeSubClass")
    }
}
var someInstance: SomeBaseClass? = SomeSubClass()
// The compile-time type of someInstance is SomeBaseClass,
// and the runtime type of someInstance is SomeSubClass

someInstance = nil

//Swift.type(of: someInstance).printClassName()
//Prints "SomeSubClass"
//SomeSubClass.printClassName()
