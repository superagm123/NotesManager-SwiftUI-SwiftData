//
//  UIColor+extension.swift
//  Notes
//
//  Created by Alfonso Gonzalez Miramontes on 04/02/25.
//

import Foundation
import SwiftUI
import UIKit

extension UIColor {
    var suColor: Color {
        switch self {
        case .systemTeal:
            return Color.teal
        case .systemGreen:
            return Color.green
        case .systemYellow:
            return Color.yellow
        case .systemOrange:
            return Color.orange
        case .systemPurple:
            return Color.purple
        case .systemPink:
            return Color.pink
        case .systemBrown:
            return Color.brown
        default:
            return Color.clear
        }
    }
}
