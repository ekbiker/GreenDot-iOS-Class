//: Playground - noun: a place where people can play

import UIKit
import Foundation

//enum, this looks very much like java
enum LunchChoices {
    case shogun
    case ichima
    case pitfire
    case robins
    case makoBowl
    case subway
    case chipolet
}
let myLunchChoice: LunchChoices = LunchChoices.shogun
//the type is LunchChoices and the value is shogun
print(myLunchChoice)



//enums can have a raw value, like in c or c#
enum LunchStarRating: String {
    case one = "One"
    case two
    case three
    case four
    case five
}
let myRating = LunchStarRating.three
let myRatingRaw = LunchStarRating.three.rawValue
//raw values can be String, Character, or any Int or Float



//enums can have assoicated values (these values can be different types)
// you can think of it as a piggyback values
enum LunchCuisine {
    case chinese(String) //subtype
    case mexican(Int) //spicy level
    case japanese
    indirect case fusion(LunchCuisine, LunchCuisine) //recursive associated values
}
var myCuisine: LunchCuisine = LunchCuisine.chinese("Mongolian")
//myCuisin = .mexican(8)
//myCuisin = .japanese
//myCuisine = .fusion(LunchCuisine.mexican(8), LunchCuisine.japanese)

switch myCuisine {
case .chinese(let subType):
    print("Chinese - subType: \(subType)")
case .mexican(let spicyLevel):
    print("Mexican - spicyLevel: \(spicyLevel).")
case .japanese:
    print("Japanese")
case .fusion(let cuisine1, let cuisine2):
    print("Fusion - \(cuisine1) and \(cuisine2)")
}

