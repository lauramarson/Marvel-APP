//
//  ApiParameters.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 15/11/22.
//

import Foundation

struct APIParameters {
    private let baseEndpoint = "http://gateway.marvel.com/"
    private let publicApiKeyParam = "&apikey=\(APIKey.publicKey)"
    private let timestamp = "\(Date().timeIntervalSince1970)"
    
    private var hashParam: String {
        "&ts=\(timestamp)&hash=" + ("\(timestamp)\(APIKey.privateKey)\(APIKey.publicKey)").md5
    }
    
    func url(type: RequestType, offset: Int) -> URL? {
        switch type {
        case .searchCharacters(name: _):
            let urlString = "\(baseEndpoint)\(type.endpoint)&offset=\(offset)\(publicApiKeyParam)\(hashParam)"
            return URL(string: urlString)
        default:
            let urlString = "\(baseEndpoint)\(type.endpoint)?offset=\(offset)\(publicApiKeyParam)\(hashParam)"
            return URL(string: urlString)
        }
    }
}



