//
//  ErrorViewModel.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 23/11/22.
//

import Foundation

struct ErrorViewModel {
    private(set) var title: String
    private(set) var message: String
    private(set) var buttonName: String
    let action: () -> Void
    
    init(title: String, message: String, buttonName: String, action: @escaping () -> Void) {
        self.title = title
        self.message = message
        self.buttonName = buttonName
        self.action = action
    }
}
