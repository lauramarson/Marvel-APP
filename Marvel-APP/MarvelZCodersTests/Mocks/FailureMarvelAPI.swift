//
//  FailureMarvelAPI.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 17/11/22.
//

import Foundation
@testable import MarvelZCoders

struct FailureMarvelAPI: MarvelAPIContract {
    func makeRequestFor<T>(_ request: MarvelZCoders.APIRequest, responseType: T.Type, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        let error = MockError()
        completion(.failure(error))
    }
}

struct MockError: Error {
    let localizedDescription = "Couldn't fetch data"
}
