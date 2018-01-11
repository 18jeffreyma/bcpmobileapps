//: Playground - noun: a place where people can play

import UIKit

var grade = 89.5

func getLetterGrade(inputGrade:Double) -> String {
    
    var letter: String
    if 89.5 <= inputGrade {
        letter = "A"
    } else if 79.5 <= inputGrade {
        letter = "B"
    } else if 69.5 <= inputGrade {
        letter = "C"
    } else {
        letter = "NP"
    }
    
    return letter
}

func getLetterGradeSwitchCase(inputGrade:Double) -> String {
    
    
    let intGrade = (Int)(inputGrade*10)
    
    var letter: String
    
    switch intGrade {
        case 895...1000:
            letter = "A"
        case 795...895:
            letter = "B"
        case 695...795:
            letter = "C"
        default:
            letter = "NP"
    }
    
    return letter
}


print(getLetterGrade(inputGrade: grade))
print(getLetterGradeSwitchCase(inputGrade: grade))








