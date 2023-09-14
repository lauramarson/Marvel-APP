//
//  NetworkResponse.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 18/11/22.
//

import Foundation

struct NetworkResponse<Wrapped: Decodable>: Decodable {
    var data: Wrapped
}
