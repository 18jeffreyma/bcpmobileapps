//: Playground - noun: a place where people can play

import UIKit




func genererateCountedStrings( inputStrings: [String]) -> [String: Int] {
    var finalReturn: [String: Int] = [:]
    for string in inputStrings {
        if (finalReturn.index(forKey: string) == nil){
            finalReturn[string] = 1
        } else {
            finalReturn[string] = finalReturn[string]! + 1
        }
    }
    return finalReturn
}

var strings1 = ["tuples", "are", "awesome", "tuples", "are", "cool",
               "tuples", "tuples", "tuples", "shades"]
var countedStrings1: [String: Int] = genererateCountedStrings(inputStrings: strings1)
print(countedStrings1)

var strings2 = ["hello", "world", "hello", "swift", "hello", "tuples"]
var countedStrings2: [String: Int] = genererateCountedStrings(inputStrings: strings2)
print(countedStrings2)
