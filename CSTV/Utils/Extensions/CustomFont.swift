//
//  CustomFont.swift
//  CSTV
//
//  Created by Juliana Prado on 08/08/23.
//

import Foundation
import SwiftUI

// Custom Roboto Font
extension Font {
    enum RobotoFont: String {
        case Regular = "Roboto-Regular.tff"
        case BoldItalic = "Roboto-BoldItalic"
        case ExtraBoldItalic = "Roboto-BlackItalic"
        case Italic = "Roboto-Italic"
        case Light = "Roboto-Light"
        case LightItalic = "Roboto-LightItalic"
        case SemiBold = "Roboto-Medium"
        case SemiBoldItalic = "Roboto-MediumItalic"
        case Bold = "Roboto-Bold"
    }
    
    /// Custom Roboto Font Setter
    /// - Parameters:
    ///   - type: Weight Type
    ///   - size: Font Size
    /// - Returns: Roboto Font with weight and size
    static func roboto(_ type: RobotoFont, size: CGFloat = 10) -> Font {
        return .custom(type.rawValue, size: size)
    }
}
