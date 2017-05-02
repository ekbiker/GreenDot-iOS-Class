//: Playground - noun: a place where people can play

import UIKit

class MyClass1 {
    var property: String?
    let defaultedProp = "properties can take default values"
    lazy var lazyProperty = ComplicatedManager() //lazy instantiation is not thread safe
    //Global constants and variables are always computed lazily
    static let staticProperty: Int = 0
    
    let stored: String = "I'm a stored propertey"
    var computed: String {
        //computed properties, no storage backing
        get {
            return "I'm computed"
        }
        set(newValue) {
            //also can use shorthand notation to avoid explict name
            print("set: \(newValue)")
        }
        //remove setter to make it read only
        //getter can also use shorthand
    }
    var observed: String = "you can add observers for stored properties" {
        //not for lazy
        //observers not called during init
        willSet(newValue) {
            print("willSet: new: \(newValue)")
        }
        didSet(oldValue) {
            //observed = oldValue //legal, does not cause recurrsion
            print("didSet: old: \(oldValue)")
        }
    }
    func function1() {
        
    }
    static func function2() {
        
    }
}
class ComplicatedManager {
    var filename = "data.txt"
}
//let test = MyClass1()
//test.observed = "new value"

class MyOtherClass: MyClass1 {
    override init() {
        super.init()
        observed = "new value"
    }
    override var computed: String {
        get {
            return "new value"
        }
        set {
            //
        }
    }
}
//let test = MyOtherClass()
//test.observed = "new value"

class MyOtherClass1: MyClass1 {
    override var computed: String {
        didSet {
            print("MyOtherClass1 didset")
        }
    }
}
let test = MyOtherClass1()
test.computed = "new value"
