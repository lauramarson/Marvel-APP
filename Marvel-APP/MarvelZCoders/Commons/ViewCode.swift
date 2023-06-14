//
//  ViewCode.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 07/06/23.
//

import UIKit

protocol ViewCode {
    func loadView()
    func addSubviews()
    func addConstraints()
    func additionalConfig()
}

extension ViewCode {
    func loadView() {
        addSubviews()
        addConstraints()
        additionalConfig()
    }
    
    func additionalConfig() { /* Intentionally unimplemented */ }
}
