//
//  NetworkManagerMock.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 13/09/23.
//

import Foundation
@testable import MarvelZCoders

class MarvelNetworkManagerSuccessMock: NetworkManagerProtocol {
    func makeRequestWith<T>(_ request: APIRequestProtocol, completion: @escaping (Result<T, NetworkError>) -> ()) where T : Decodable {
        let marvelRequest = request as! MarvelRequest
        
        switch marvelRequest {
        case .charactersList(let offset):
            let fetchedCharacters = MarvelMockData.charactersList(offset: offset)
            let charactersResults = CharactersResponse(results: fetchedCharacters)
            let networkResponse = NetworkResponse(data: charactersResults)
            completion(.success(networkResponse as! T))
            
        case .searchCharacters(let name, let offset):
            let fetchedCharacters = MarvelMockData.searchCharacters(name: name, offset: offset)
            let charactersResults = CharactersResponse(results: fetchedCharacters)
            let networkResponse = NetworkResponse(data: charactersResults)
            completion(.success(networkResponse as! T))
            
        case .comicsForCharacter(let id, let offset):
            let fetchedComics = MarvelMockData.comicsForCharacter(id: id, offset: offset)
            let comicsResults = ComicsResponse(results: fetchedComics)
            let networkResponse = NetworkResponse(data: comicsResults)
            completion(.success(networkResponse as! T))
            
        case .charactersForComic(let id, let offset):
            let fetchedCharacters = MarvelMockData.charactersForComic(id: id, offset: offset)
            let charactersResults = CharactersResponse(results: fetchedCharacters)
            let networkResponse = NetworkResponse(data: charactersResults)
            completion(.success(networkResponse as! T))
        }
    }
}

class NetworkManagerFailureMock: NetworkManagerProtocol {
    func makeRequestWith<T>(_ request: APIRequestProtocol, completion: @escaping (Result<T, NetworkError>) -> ()) where T : Decodable {
        let error = NetworkError.unableToFetchData
        completion(.failure(error))
    }
}
