//
//  SuccessMarvelAPI.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 16/11/22.
//

import Foundation
@testable import MarvelZCoders

struct SuccessMarvelAPI: MarvelAPIContract {
    func makeRequestFor<T>(_ request: APIRequest, responseType: T.Type = T.self, completion: @escaping (Result<T, Error>) -> ()) {
        
        let requestType = request.requestType
        let offset = request.offset
        
        switch requestType {
            
        case .charactersList:
            var charactersResults = CharactersResults(results: [])
            var fetchedCharacters: [Character] = []
            
            for num in offset..<(offset + 20) {
                let newCharacter = Character(id: num, name: "Character \(num)", description: "Descrição", thumbnail: nil)
                fetchedCharacters.append(newCharacter)
            }
            charactersResults.results = fetchedCharacters
            completion(.success(charactersResults as! T))
            
        case .searchCharacters(name: let name):
            var charactersResults = CharactersResults(results: [])
            var fetchedCharacters: [Character] = []
            
            for num in offset..<(offset + 20) {
                let newCharacter = Character(id: num, name: "\(name)", description: "Descrição", thumbnail: nil)
                fetchedCharacters.append(newCharacter)
            }
            charactersResults.results = fetchedCharacters
            completion(.success(charactersResults as! T))
            
        case .comicsForCharacter(id: _):
            var comicsResults = ComicsResults(results: [])
            var fetchedComics: [Comic] = []
            
            for num in offset..<(offset + 20) {
                let newComic = Comic(id: num, title: "Comic \(num)", thumbnail: nil)
                fetchedComics.append(newComic)
            }
            comicsResults.results = fetchedComics
            completion(.success(comicsResults as! T))
            
        case .charactersForComic(id: _):
            var charactersResults = CharactersResults(results: [])
            var fetchedCharacters: [Character] = []
            
            for num in offset..<(offset + 20) {
                let newCharacter = Character(id: num, name: "Character \(num)", description: "Descrição", thumbnail: nil)
                fetchedCharacters.append(newCharacter)
            }
            charactersResults.results = fetchedCharacters
            completion(.success(charactersResults as! T))
        }
    }
    
}
