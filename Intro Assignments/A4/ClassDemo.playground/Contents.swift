//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Person :Equatable {
    var height: Int
    var age: Int
    var name: String
    
    init() {
        height = 0
        age = 0
        name = ""
    }
    
    init(name: String, age: Int, height: Int) {
        self.name = name
        self.age = age
        self.height = height
    }
    
    func changeName(newName: String) {
        self.name = newName
    }
    
    func grow(heightGrown: Int) {
        self.height += heightGrown
    }
    
    func birthdayed() {
        self.age += 1
    }
    
}

func ==(person1: Person, person2: Person) -> Bool{
    return (person1.name == person2.name && person1.age == person2.age && person1.height == person2.height)
}

var jeffrey = Person(name: "Jeffrey Ma", age: 14, height: 71)
var jeffreyClone = Person(name: "Jeffrey Ma", age: 14, height: 71)
var alexander = Person(name: "Alexander Knappen", age: 20, height: 61)
var josh = Person(name: "Josh Holden", age: 28, height: 58)
var phillip = Person(name: "Phillip Si", age: 24, height: 60)

// remember to do equatable things
print("Is Jeffrey equal to his clone? " + String(jeffreyClone==jeffrey))


