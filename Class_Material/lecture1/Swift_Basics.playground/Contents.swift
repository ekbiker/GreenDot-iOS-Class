//: Playground - noun: a place where people can play

import UIKit
import Foundation

//declaring variables
let num = Int(3) //always use let until compiler tells you to use var
var str = "Hello playground"
str = "hello Swift"
let a = "a"; let b = "b"

let float = Float(10_000.009)
let anotherFloat = 10_000.009 //Swift infers Double
let int = Int(00001)
let anotherInt = 1083473757088876724

let `private` = "using reserved keyword as a variable name"
let _mySelf = "underscore is allowed"
let MySelf = "uppercase are used for types"
let mySelf = "lowercase are used for variables or methods"
//let 1self = "digits cannot lead a variable name"
let self1 = "but digits can be used elsewhere"



//declaring a type, swift inferrence
let myStr: String = String("myString")
//let myVar = String("myString")
//let myVar = "myString"
let myFloat: Float = Float(1000.999)
let myBool: Bool = Bool(true)
//Array
let myArray: Array<String> = Array<String>(arrayLiteral: "one", "two", "three")
//Dictionary
let myDict: Dictionary<String, String> = Dictionary<String, String>(dictionaryLiteral: ("key1","val1"), ("key2","val2"))
//Optional
var optionalString: Optional<String> = Optional<String>("hello swift")
optionalString = nil
//compound types
let myTuple: (String, Int)? = ("name", 10) //player name, score
let myFunction: ((String)->Bool)? = {(String)->Bool in
    return false
}
//Optional Int
var optionalInt: Int? = nil
optionalInt = 1
print(optionalInt!)


//Basic Swift data constructs, the foundation of all other types
class MyClass {
    var name: String = ""
    func someFunction() {
        
    }
    let someProperty: String = {
        // create a default value for someProperty inside this closure
        // someValue must be of the same type as SomeType
        return "some value"
    }()
}
struct MyStruct {
    var name: String
    static func staticFunc() {
        
    }
}
enum MyEnum {
    
}
protocol MyProtocol {
    
}


//structs and enums are always passed by value
let myStruct = MyStruct(name: "Ted")
print(myStruct.name)
var aStruct = myStruct
print(aStruct.name)
aStruct.name = "John"
print(aStruct.name)
print(myStruct.name)



//classes are always passed by reference
let myClass = MyClass()
myClass.name = "Ted"
print(myClass.name)
var aClass = myClass
print(aClass.name)
aClass.name = "John"
print(aClass.name)
print(myClass.name)



//function arguments are always copied(new storage is created), but by value or by pointer
func printName (_  s: MyStruct, c: MyClass) {
    print("before: \(s.name)")
    print("before: \(c.name)")
    
    var m = s
    m.name = "Joe"
    c.name = "Joe"
    print(m.name)
    print(s.name)
    print(c.name)
    
}
printName(aStruct, c: aClass)
print(aClass.name)


//nested types, prevent namespace pollution
struct AnotherStruct {
    enum NestedEnum {
        class NestedClass {
            
        }
    }
    struct NestedStruct{
        
    }
    class NestedClass {
        
    }
}
let nestedClass = AnotherStruct.NestedEnum.NestedClass()
let anotherNestedClass = AnotherStruct.NestedClass()



//typealias
typealias T = AnotherStruct.NestedEnum.NestedClass
let test = T()

typealias Point = (Int, Int)
let origin: Point = (0, 0)

typealias MyBlock = ()->Void
let block = {()->Void in }



//extensible
extension MyClass {
    
}
extension MyStruct {
    
}
extension MyEnum {
    
}
extension MyProtocol {
    //provide default implementations
}



//type casting
class FirstSubClass: MyClass {
    
}
class SecondSubClass: MyClass {
    
}
let instances: [Any] = [FirstSubClass(), SecondSubClass(), MyClass(), MyStruct(name:"hello")]

func checkType(_ instance: Any) {
    if let _ = instance as? MyClass {
        print("MyClass")
    }
}

for instance in instances {
    if instance is FirstSubClass {
        print("It's FirstSubClass")
    }
    else if instance is SecondSubClass {
        print("It's SecondSubClass")
    }
    checkType(instance)
}



//initialization
class TestClass {
    //var name: String
    init() {
        
    }
    init(name: String) {
        
    }
    init(_ int: Int) {
        
    }
    init?(_ double: Double) {
        
    }
}
let val = TestClass(123)
let double = TestClass(1.0)

//initializer delegation
extension MyStruct {
    init(special: String) {
        self.init(name: special)
    }
}



//overridding, add final to original declaration to demonstrate
class AnotherClass: MyClass {
    override func someFunction() {
        
    }
}
