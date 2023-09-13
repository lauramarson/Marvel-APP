//
//  NetworkManager.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 31/07/23.
//

import Foundation

protocol NetworkManagerProtocol {
    func makeRequestWith<T: Decodable>(_ request: APIRequestProtocol, completion: @escaping (Result<T, NetworkError>) -> ())
}

class NetworkManager: NetworkManagerProtocol {
    private let session: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        session = urlSession
    }
    
    func makeRequestWith<T>(_ request: APIRequestProtocol, completion: @escaping (Result<T, NetworkError>) -> ()) where T : Decodable {
        guard let urlRequest = request.createURLRequest() else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: urlRequest) { data, response, error in
            
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
                let json = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(json))
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
        }.resume()
    }
}
