//: Playground - noun: a place where people can play

import UIKit

var opt: Int?
opt = Optional<Int>.some(1234)

print(opt)
print(opt!)

//optional chaining
opt?.description


if opt?.description != nil {
    print("opt is not nil")
}

let strings: [String]? = nil //["one", "two", "three"]
print(strings?[0])

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]


//checking for optionals
if opt != nil {
    print(opt!)
}


//optional binding
if let value = opt {
    //do something
    print(value)
}

if let desc = opt?.description {
    print("description: \(desc)")
}

func demonstrateGuard(_ int: Int?) {
    guard let value = opt else {
        //stop and return
        return
    }
    print(value) //value in scope
}


//implicitly unwrapped
var unwrapped: String! = "unwrapped"
print(unwrapped)


