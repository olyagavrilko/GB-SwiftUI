//
//  CodingStyle.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 13.04.2022.
//

import SwiftUI

@propertyWrapper
class CodingStyle {
    
    enum Style {
        case camel
        case snake
        case kebab
        case mostPopular
    }

    private var value = ""
    
    private let style: Style
    
    var wrappedValue: String {
        get {
           value
        }
        set {
            value = applyStyle(style: style, string: newValue)
        }
    }
    
    init(wrappedValue: String, style: Style) {
        self.style = style
        self.wrappedValue = wrappedValue
    }
    
    func applyStyle(style: Style, string: String) -> String {
        
        switch style {
        case .camel:
            return string.capitalized.replacingOccurrences(of: " ", with: "")
        case .snake:
            return string.replacingOccurrences(of: " ", with: "_")
        case .kebab:
            return string.replacingOccurrences(of: " ", with: "-")
        case .mostPopular:
            let style = checkStyle(string)
            let newString = prepareStringForStyle(string)
            return applyStyle(style: style, string: newString)
        }
    }
    
    func checkStyle(_ value: String) -> Style {
        var camelCount = 0
        var snakeCount = 0
        var kebabCount = 0
        
        var dictOfStyle: [Style: Int] = [:]
        var maxValue = 0
        var mostPopularCase: Style = .camel
        
        var preparedString = value
        
        for character in value {
            if character.isUppercase {
                camelCount += 1
            } else if character == "_" {
                snakeCount += 1
            } else if character == "-" {
                kebabCount += 1
            }
        }
        
        dictOfStyle[.camel] = camelCount
        dictOfStyle[.snake] = snakeCount
        dictOfStyle[.kebab] = kebabCount
        
        for (key, value) in dictOfStyle {
            if value > maxValue {
                maxValue = value
                mostPopularCase = key
            }
        }
        
        if camelCount > 0 {
            preparedString = preparedString.lowercased()
        } else if snakeCount > 0 {
            preparedString = preparedString.replacingOccurrences(of: "_", with: " ")
        } else if kebabCount > 0 {
            preparedString = preparedString.replacingOccurrences(of: "-", with: " ")
        }
        
        return mostPopularCase
    }
    
    func prepareStringForStyle(_ string: String) -> String {
        
        var newString = string.replacingOccurrences(of: "_", with: " ")
        newString = newString.replacingOccurrences(of: "-", with: " ")
        
        var insertIndexes: [Int] = []
        var previousChar: Character?
        for (index, character) in newString.enumerated() {
            if character.isUppercase && index != 0 && previousChar != " " {
                insertIndexes.append(index)
            }
            previousChar = character
        }
        
        newString = newString.lowercased()
        
        for index in insertIndexes.reversed() {
            let strIndex = newString.index(newString.startIndex, offsetBy: index)
            newString.insert(" ", at: strIndex)
        }
        
        return newString
    }
}
