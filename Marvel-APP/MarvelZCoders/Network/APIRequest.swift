//
//  APIRequest.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 18/11/22.
//

import Foundation

struct APIRequest {
    var requestType: RequestType
    var offset = 0
    
    var url: URL? {
        APIParameters().url(type: requestType, offset: offset)
    }
}

enum RequestType {
    case charactersList
    case searchCharacters(name: String)
    case comicsForCharacter(id: Int)
    case charactersForComic(id: Int)
    
    var endpoint: String {
        switch self {
        case .charactersList:
            return "v1/public/characters"
        case .searchCharacters(name: let name):
            let words = name.replacingOccurrences(of: " ", with: "%20")
            return "v1/public/characters?nameStartsWith=\(words)"
        case .comicsForCharacter(id: let characterId):
            return "/v1/public/characters/\(characterId)/comics"
        case .charactersForComic(id: let comicId):
            return "/v1/public/comics/\(comicId)/characters"
        }
    }
}
