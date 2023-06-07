//
//  UIView+Extension.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 16/11/22.
//

import UIKit

fileprivate let timeIntervalDefault = 1.0

extension UIView {
    
    func fadeIn(duration: TimeInterval = timeIntervalDefault) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(duration: TimeInterval = timeIntervalDefault) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
}
