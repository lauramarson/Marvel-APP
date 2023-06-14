//
//  CharacterDetailViewModel.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 19/11/22.
//

import Foundation

class CharacterDetailViewModel {
    private let limit = 20
    private(set) var comicsCount = 0
    private(set) var isDataLoading = false
    
    weak var delegate: CharacterDetailViewModelDelegate?
    
    private var marvelAPI: MarvelAPIContract?
    var character: Character?
    
    var comicsList: [Comic] = [] {
        didSet {
            delegate?.characterDetailViewModelDelegate(self, didLoadComicsList: comicsList)
        }
    }
    
    init(marvelAPI: MarvelAPIContract, character: Character) {
        self.marvelAPI = marvelAPI
        self.character = character
    }
    
    func loadComics() {
        isDataLoading = true
        let request = APIRequest(requestType: .comicsForCharacter(id: character?.id ?? 0), offset: comicsCount)
        
        marvelAPI?.makeRequestFor(request, responseType: ComicsResults.self, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let comics):
                self.comicsList.append(contentsOf: comics.results)
                self.comicsCount += self.limit

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
