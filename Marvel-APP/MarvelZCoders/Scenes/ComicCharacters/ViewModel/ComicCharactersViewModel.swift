//
//  ComicCharactersViewModel.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 21/11/22.
//

import Foundation

final class ComicCharactersViewModel {
    private let limit = 20
    private(set) var charactersCount = 0
    private(set) var isDataLoading = false
    
    weak var delegate: ComicCharactersViewModelDelegate?
    
    private var marvelAPI: MarvelAPIContract?
    var comic: Comic?
    
    var charactersList: [Character] = [] {
        didSet {
            delegate?.comicCharactersViewModelDelegate(self, didLoadCharactersList: charactersList)
        }
    }
    
    init(marvelAPI: MarvelAPIContract, comic: Comic) {
        self.marvelAPI = marvelAPI
        self.comic = comic
    }
    
    func loadCharacters() {
        isDataLoading = true
        let request = APIRequest(requestType: .charactersForComic(id: comic?.id ?? 0), offset: charactersCount)
        
        marvelAPI?.makeRequestFor(request, responseType: CharactersResults.self, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let characters):
                self.charactersList.append(contentsOf: characters.results)
                self.charactersCount += self.limit
                
            case .failure(let error):
                
                if let connectionError = error as? URLError, connectionError.code == URLError.Code.notConnectedToInternet {
                    self.delegate?.noInternetConnectionDelegate()
                } else {
                    self.delegate?.unableToFetchDataDelegate()
                }

            }
            
            self.isDataLoading = false
        })
    }
}
