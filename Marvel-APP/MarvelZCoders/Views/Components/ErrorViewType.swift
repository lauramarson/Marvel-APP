//
//  ErrorViewType.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 23/11/22.
//

import Foundation

enum ErrorViewType {
    case unableToFetchData
    case noInternetConnection
    
    func getErrorViewModel(with action: @escaping () -> Void) -> ErrorViewModel {
        switch self {
        case .unableToFetchData:
            return ErrorViewModel(
                title: "Ocorreu um erro",
                message: "No momento, não foi possível carregar os dados. Tente novamente mais tarde.",
                buttonName: "Tentar novamente",
                action: action
            )
        case .noInternetConnection:
            return ErrorViewModel(
                title: "Ocorreu um erro",
                message: "Por gentileza verifique se você está com a internet ativa, caso esteja, tente novamente através do botão abaixo.",
                buttonName: "Tentar novamente",
                action: action
            )
        }
    }
}

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
