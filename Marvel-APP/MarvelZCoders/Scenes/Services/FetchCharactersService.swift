//
//  FetchCharactersService.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 02/08/23.
//

import Foundation

typealias charactersData = NetworkResponse<CharactersResponse>
typealias charactersResult = Result<charactersData, NetworkError>

protocol FetchCharactersProtocol {
    func fetchCharactersList(offset: Int, completion: @escaping (charactersResult) -> Void)
    func searchForCharacters(name: String, offset: Int, completion: @escaping (charactersResult) -> Void)
    func fetchCharactersForComic(id: Int, offset: Int, completion: @escaping (charactersResult) -> Void)
}

final class FetchCharactersService: FetchCharactersProtocol {
    private let apiManager: APIManagerContract
    
    init(apiManager: APIManagerContract = APIManager()) {
        self.apiManager = apiManager
    }
    
    func fetchCharactersList(offset: Int, completion: @escaping (charactersResult) -> Void) {
        let request = MarvelRequest.charactersList(offset: offset)
        
        apiManager.makeRequestWith(request) { result in
            completion(result)
        }
    }
    
    func searchForCharacters(name: String, offset: Int, completion: @escaping (charactersResult) -> Void) {
        let request = MarvelRequest.searchCharacters(name: name, offset: offset)
        
        apiManager.makeRequestWith(request) { result in
            completion(result)
        }
    }
    
    func fetchCharactersForComic(id: Int, offset: Int, completion: @escaping (charactersResult) -> Void) {
        let request = MarvelRequest.charactersForComic(id: id, offset: offset)
        
        apiManager.makeRequestWith(request) { result in
            completion(result)
        }
    }
}
