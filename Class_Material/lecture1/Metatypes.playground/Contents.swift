//: Playground - noun: a place where people can play

import UIKit

//metatype type
let stringType: String.Type = String.self

protocol MyProtocol{}
let myProtocolType: MyProtocol.Protocol = MyProtocol.self
let str = stringType.init("some string")


//example use
class BaseClass {
    class func printClassName() {
        print("BaseClass")
    }
}
class FirstSubClass: BaseClass {
    override class func printClassName() {
        print("FirstSubClass")
    }
}
class SecondSubClass: BaseClass {
    override class func printClassName() {
        print("SecondSubClass")
    }
}

func printMyClassName(_ instance: BaseClass) {
    type(of: instance).printClassName()
    //BaseClass.printClassName()
}
let instance: BaseClass = FirstSubClass()
printMyClassName(instance)
printMyClassName(SecondSubClass())
