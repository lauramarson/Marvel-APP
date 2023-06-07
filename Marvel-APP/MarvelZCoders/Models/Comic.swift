//
//  Comic.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 19/11/22.
//

import Foundation

struct ComicsResults: Decodable {
    var results: [Comic]
}

struct Comic: Decodable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail?
    
    var pictureURL: URL? {
        let url = (thumbnail?.path ?? "") + "." + (thumbnail?.imageExtension ?? "")
        return URL(string: url)
    }
}
