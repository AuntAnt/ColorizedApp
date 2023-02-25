//
//  DataHelper.swift
//  ColorizedApp
//
//  Created by Anton Kuzmin on 25.02.2023.
//

import Foundation

// MARK: - Helper class for changing data
final class DataHelper {
    
    /// Normalize text field value if entered value is not in range 0...1
    static func normalizeValue(number: Float) -> Float {
        if number > 1 {
            return Float(1)
        } else if number < 0 {
            return Float(0)
        } else {
            return number
        }
    }
    
    static func roundValue(_ value: Float) -> String {
        String(format: "%.2f", value)
    }
}
