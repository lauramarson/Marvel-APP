//
//  CustomError.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 15/06/23.
//

import Foundation

enum CustomError: Error {
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

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToFetchData:
            return NSLocalizedString("Por gentileza verifique se você está com a internet ativa, caso esteja, tente novamente através do botão abaixo.", comment: "Ocorreu um erro")
        case .noInternetConnection:
            return NSLocalizedString("Description of invalid password", comment: "Invalid Password")
        }
    }
}
