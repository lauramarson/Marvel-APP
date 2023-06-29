//
//  ViewCode.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 07/06/23.
//

import UIKit

public protocol ViewCode {
    func loadView()
    func addSubviews()
    func addConstraints()
    func additionalConfig()
}

public extension ViewCode {
    func loadView() {
        addSubviews()
        addConstraints()
        additionalConfig()
    }
    
    func additionalConfig() { /* Intentionally unimplemented */ }
}
