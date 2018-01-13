
import UIKit

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
var jeffreyDuplicate: Person = jeffrey
var alexander = Person(name: "Alexander Knappen", age: 20, height: 61)
var josh = Person(name: "Josh Holden", age: 28, height: 58)
var phillip = Person(name: "Phillip Si", age: 24, height: 60)

// remember to do equatable things
print("Is Jeffrey equal to his clone (same values)? " + String(jeffreyClone==jeffrey))
print("Is Jeffrey equal to his duplicate (reference)? " + String(jeffreyDuplicate==jeffrey))
print()

print("Alexander before the summer: " + String(alexander.height) + " in.")
alexander.grow(heightGrown: 10)
print("Alexander growing 10 in. after the summer: " + String(alexander.height) + " in.")
print()

print("Josh before birthday: " + String(josh.age) + " years-old")
josh.birthdayed()
print("Josh After birthday: " + String(josh.age) + " years-old")
print()

print("Phillip before name change: " + String(phillip.name))
phillip.changeName(newName: "Phillipa SIIII")
print("Phillip After name change: " + String(phillip.name))

var dictionaryOfPeople: [String: Person] = [:]

dictionaryOfPeople["Jeffrey"] = jeffrey
dictionaryOfPeople["JeffreyClone"] = jeffreyClone
dictionaryOfPeople["JeffreyDuplicate"] = jeffreyDuplicate
dictionaryOfPeople["Josh"] = josh
dictionaryOfPeople["Phillip"] = phillip
dictionaryOfPeople["Alexander"] = alexander
print()

print("People in the dictionary: ")

for (key, value) in dictionaryOfPeople {
    print("Name: " + value.name + " | Age: " + String(value.age) + " | Height: " + String(value.height) + " in.")
}




