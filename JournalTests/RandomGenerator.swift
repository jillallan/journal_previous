//
//  RandomGenerator.swift
//  JournalTests
//
//  Created by Jill Allan on 08/10/2023.
//

import CoreLocation
import Foundation

struct RandomGenerator {
    enum DateTense {
        case past, future
    }
    
    func randomCoordinate() -> CLLocationCoordinate2D {
        let latitude = Double.random(in: -90...90)
        let longitude = Double.random(in: -180...180)
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func randomWord() -> String {
        let length = Int.random(in: 5...10)
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func randomSentence() -> String {
        var length = Int.random(in: 10...20)
        var sentence = ""
        while length > 0 {
            sentence.append(randomWord())
            sentence.append(" ")
            length -= 1
        }
        sentence.append(randomWord())
        sentence.append(".")
        return sentence
    }
    
    func randomParagraph() -> String {
        let length = Int.random(in: 4...8)
        var paragraph = ""
        for _ in Range(1...length) {
            paragraph.append(randomSentence())
            paragraph.append(" ")
        }
        return paragraph
    }
}
