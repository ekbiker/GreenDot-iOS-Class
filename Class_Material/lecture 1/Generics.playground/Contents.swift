//: Playground - noun: a place where people can play

import UIKit

//how to declare and use
let o = Optional<String>("") //define generics using pointy bracket



//generic functions
func genericFunction<T>(instance: T) {
    //do something with instance of type T
}
//generics prevent code duplication
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}
func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var val1 = "one"
var val2 = "two"
swapTwoValues(&val1, &val2)
print(val1)
print(val2)
//is T an actual type?



//multiple type parameter
func threeValues<T, U, V>(_ a: T, _ b: U, c: V) {
    //do something
}




//genric Types
class Processor<T: BaseProcessor> {
    func printSomthing() {
        T.printProcessorName()
    }
}
class PTS: BaseProcessor {
    static func printProcessorName() {
        print("PTS")
    }
}
class TSys: BaseProcessor {
    static func printProcessorName() {
        print("TSys")
    }
}
protocol BaseProcessor {
    static func printProcessorName()
}

let proc1 = Processor<PTS>()
proc1.printSomthing()

let proc2 = Processor<TSys>()
proc2.printSomthing()
//is proc1 and proc2 the same type?



