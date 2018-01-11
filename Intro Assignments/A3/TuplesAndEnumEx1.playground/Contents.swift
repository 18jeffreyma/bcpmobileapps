//: Playground - noun: a place where people can play

import UIKit

enum Direction {
    case Up
    case Down
    case Left
    case Right
}

var location = (x: 0, y: 0)

var steps: [Direction] = [.Up, .Up, .Left, .Down, .Left]

func getFinalLocation(initialLocation : (x : Int, y : Int), takenSteps:[Direction]) -> (x: Int, y: Int) {
    
    var finalLocation = (x: initialLocation.x, y: initialLocation.y)
    
    for step in takenSteps {
        switch step {
            case .Up:
                finalLocation.y += 1
            case .Down:
                finalLocation.y -= 1
            case .Left:
                finalLocation.x -= 1
            case .Right:
                finalLocation.x += 1
        }
    }
    
    return finalLocation
    
}

// Test 1 (-2,1)
var location1 = (x: 0, y: 0)
var steps1: [Direction] = [.Up, .Up, .Left, .Down, .Left]
print(getFinalLocation(initialLocation: location1, takenSteps: steps1))

// Test 2 (1,-2)
var location2 = (x: 0, y: 0)
var steps2: [Direction] = [.Up, .Up, .Left, .Down, .Left, .Down, .Down,
                          .Right, .Right, .Down, .Right]
print(getFinalLocation(initialLocation: location2, takenSteps: steps2))

// Test 3 (9,4)
var location3 = (x: 5, y: 2)
var steps3: [Direction] = [.Up, .Right, .Up, .Right, .Up,
                          .Right, .Down, .Right]
print(getFinalLocation(initialLocation: location3, takenSteps: steps3))
