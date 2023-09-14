//
//  MockData.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 13/09/23.
//

import Foundation
@testable import MarvelZCoders

struct MarvelMockData {
    static func charactersList(offset: Int) -> [Character] {
        var fetchedCharacters: [Character] = []
        
        for num in offset..<(offset + 20) {
            let newCharacter = Character(id: num, name: "Character \(num)", description: "Descrição", thumbnail: nil)
            fetchedCharacters.append(newCharacter)
        }
        
        return fetchedCharacters
    }
    
    static func searchCharacters(name: String, offset: Int) -> [Character] {
        var fetchedCharacters: [Character] = []
        
        for num in offset..<(offset + 20) {
            let newCharacter = Character(id: num, name: "\(name)", description: "Descrição", thumbnail: nil)
            fetchedCharacters.append(newCharacter)
        }
        
        return fetchedCharacters
    }
    
    static func comicsForCharacter(id: Int, offset: Int) -> [Comic] {
        var fetchedComics: [Comic] = []
        
        for num in offset..<(offset + 20) {
            let newComic = Comic(id: num, title: "Comic \(num)", thumbnail: nil)
            fetchedComics.append(newComic)
        }
        
        return fetchedComics
    }
    
    static func charactersForComic(id: Int, offset: Int) -> [Character] {
        var fetchedCharacters: [Character] = []
        
        for num in offset..<(offset + 20) {
            let newCharacter = Character(id: num, name: "Character \(num)", description: "Descrição", thumbnail: nil)
            fetchedCharacters.append(newCharacter)
        }
        
        return fetchedCharacters
    }
}
