//
//  UIColorExtensions.swift
//  ColorizedApp
//
//  Created by Anton Kuzmin on 24.02.2023.
//

import UIKit

extension UIColor {
    var rgb: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 1
        
        // СGFloat is a structure, so & - mean inout, and params will be changed
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue)
    }
}
