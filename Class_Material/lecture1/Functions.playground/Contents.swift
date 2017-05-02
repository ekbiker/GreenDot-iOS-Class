//: Playground - noun: a place where people can play

import UIKit

func plainFunction() {
    
}

func functionsWithParams (_ param: String) {
    
}

//default parameters, automatic overloads
func functionWithDefaultParams(_ param: String = "default") {
    print(param)
}
//functionWithDefaultParams()
functionWithDefaultParams("Hello")


//nested functions
func functionsWithNestedFunctions() {
    func nestedFunction() {
        print("nested function")
    }
    nestedFunction()
}
functionsWithNestedFunctions()


//ending closures
func functionWithEndingClosure(closure: ()->Void) {
    closure()
}
functionWithEndingClosure {
    print("ending closure")
    print("")
}

class TestClass {
    func asyncFunctionWithClosure(_ closure: @escaping()->Void) {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {timer in
            closure()
        }
    }
}
TestClass().asyncFunctionWithClosure({
    print("async ending closure")
})



//function with inout params
var strings = ["one", "two", "three"]
print(strings)
func functionWithInoutParam(_ strings: inout [String]) {
    strings.append("four")
}
functionWithInoutParam(&strings)
print(strings)


//variadic parameters
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// returns 3.0, which is the arithmetic mean of these five numbers
arithmeticMean(3, 8.25, 18.75)
// returns 10.0, which is the arithmetic mean of these three numbers
//can only have one variadic argument for each function


//multiple return values
func functionsWithMultiValueReturn() -> (Int, String) {
    return (1, "One")
}
let (num, str) = functionsWithMultiValueReturn()
print(num)
print(str)



