//
//  NetworkError.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 29/06/23.
//

import Foundation

enum NetworkError: Error {
    case unableToFetchData
    case noInternetConnection
    case unableToDecodeData
    case emptySearch
    
    func getErrorViewModel(with action: @escaping () -> Void) -> ErrorViewModel {
        switch self {
        case .noInternetConnection:
            return ErrorViewModel(
                title: "Ocorreu um erro",
                message: "Por gentileza verifique se você está com a internet ativa, caso esteja, tente novamente através do botão abaixo.",
                buttonName: "Tentar novamente",
                action: action
            )
            
        case .emptySearch:
            return ErrorViewModel(
                title: "Oops...",
                message: "Infelizmente, não encontramos personagens com esse nome.",
                buttonName: "Ok",
                action: action
            )
            
        default:
            return ErrorViewModel(
                title: "Ocorreu um erro",
                message: "No momento, não foi possível carregar os dados. Tente novamente mais tarde.",
                buttonName: "Tentar novamente",
                action: action
            )
        }
    }
}
