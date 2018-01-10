//: Playground - noun: a place where people can play

import UIKit

var grade = 89.5


func getLetterGrade(_ inputGrade:Double) -> String {
    
    var letter: String
    if 89.5 < inputGrade {
        letter = "A"
    } else if 79.5 < inputGrade {
        letter = "B"
    } else if 69.5 < inputGrade {
        letter = "C"
    } else {
        letter = "NP"
    }
    
    return letter
}

func getLetterGradeSwitchCase(_ inputGrade:Double) -> String {
    
    var letter: String
    
    switch inputGrade {
        case 89.5...100:
            letter = "A"
        case 79.5...89.5:
            letter = "B"
        case 69.5...79.5:
            letter = "C"
        default:
            letter = "NP"
    }
    
    return letter
}


print(getLetterGrade(grade))
print(getLetterGradeSwitchCase(grade))








