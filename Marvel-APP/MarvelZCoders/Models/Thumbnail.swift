//
//  Thumbnail.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 19/11/22.
//

import Foundation

struct Thumbnail: Decodable {
    let path: String
    let imageExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
