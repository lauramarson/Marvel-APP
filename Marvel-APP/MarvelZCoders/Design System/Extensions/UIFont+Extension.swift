//
//  UIFont+Extension.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 16/11/22.
//

import UIKit

extension UIFont {
    static func cairo(_ type: FontType, size: CGFloat) -> UIFont? {
        return UIFont(name: "Cairo-\(type)", size: size)
    }
    
    static func inder(_ type: FontType, size: CGFloat) -> UIFont? {
        return UIFont(name: "Inder-\(type)", size: size)
    }
    
    enum FontType: String {
        case regular = "Regular"
        case semibold = "SemiBold"
        case bold = "Bold"
    }
}
