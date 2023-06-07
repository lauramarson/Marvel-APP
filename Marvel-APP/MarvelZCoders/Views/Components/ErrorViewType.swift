//
//  ErrorViewType.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 23/11/22.
//

import Foundation

struct ErrorViewType {
    private(set) var title: String
    private(set) var message: String
    private(set) var buttonName: String
    
    init(title: String, message: String, buttonName: String) {
        self.title = title
        self.message = message
        self.buttonName = buttonName
    }
}
