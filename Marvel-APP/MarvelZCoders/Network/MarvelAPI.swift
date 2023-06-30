//
//  MarvelAPI.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 10/11/22.
//

import Foundation

protocol MarvelAPIContract {
    func makeRequestFor<T: Decodable>(_ request: APIRequest, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> ())
}

struct MarvelAPI: MarvelAPIContract {
    private let session = URLSession.shared
    
    func makeRequestFor<T: Decodable>(_ request: APIRequest, responseType: T.Type = T.self, completion: @escaping (Result<T, NetworkError>) -> ()) {
        
        guard let url = request.url else { return }
        
        session.dataTask(with: url, completionHandler: { data, response, error in

            if let error = error {
                var networkError: NetworkError = .unableToFetchData
                
                if let connectionError = error as? URLError, connectionError.code == URLError.Code.notConnectedToInternet {
                    networkError = .noInternetConnection
                }
                
                DispatchQueue.main.async {
                    completion(.failure(networkError))
                }
            }

            do {
                guard let data = data else { return }
                let json = try JSONDecoder().decode(NetworkResponse<T>.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(json.data))
                }
            } catch let error as DecodingError {
                switch error {
                case .dataCorrupted(let context):
                    print(context)
                    
                case .keyNotFound(let key, let context):
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)

                case .typeMismatch(let type, let context):
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)

                case .valueNotFound(let value, let context):
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)

                @unknown default:
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    completion(.failure(.unableToDecodeData))
                }

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.unableToDecodeData))
                }
            }
        }).resume()
    }
}
