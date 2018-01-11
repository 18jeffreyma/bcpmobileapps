//: Playground - noun: a place where people can play

import UIKit

enum HandShape {
    case Rock
    case Paper
    case Scissors
}

enum MatchResult {
    case Win
    case Draw
    case Lose
}

func match(_ you:HandShape, _ opponent:HandShape) -> MatchResult {
    if (you == opponent) {
        return MatchResult.Draw
    } else {
        if (you == .Paper && opponent == .Rock) {
            return MatchResult.Win
        } else if (you == .Rock && opponent == .Scissors) {
            return MatchResult.Win
        } else if (you == .Scissors && opponent == .Paper) {
            return MatchResult.Win
        } else {
            return MatchResult.Lose
        }
    }
}

print(match(.Rock, .Scissors))
print(match(.Rock, .Paper))
print(match(.Scissors, .Scissors))



