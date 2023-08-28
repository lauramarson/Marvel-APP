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
    
//    private var marvelAPI: MarvelAPIContract?
    private let charactersService: FetchCharactersProtocol
    var comic: Comic?
    
    var charactersList: [Character] = [] {
        didSet {
            delegate?.comicCharactersViewModelDelegate(self, didLoadCharactersList: charactersList)
        }
    }
    
//    init(marvelAPI: MarvelAPIContract, comic: Comic) {
//        self.marvelAPI = marvelAPI
//        self.comic = comic
//    }
    
    init(charactersService: FetchCharactersProtocol = FetchCharactersService(), comic: Comic) {
        self.charactersService = charactersService
        self.comic = comic
    }
    
    func loadCharacters() {
        isDataLoading = true
//        let request = APIRequest(requestType: .charactersForComic(id: comic?.id ?? 0), offset: charactersCount)
//
//        marvelAPI?.makeRequestFor(request, responseType: CharactersResponse.self, completion: { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let characters):
//                self.charactersList.append(contentsOf: characters.results)
//                self.charactersCount += self.limit
//
//            case .failure(let error):
//                self.delegate?.showError(error)
//            }
//
//            self.isDataLoading = false
//        })
        
        charactersService.fetchCharactersForComic(id: comic?.id ?? 0, offset: charactersCount) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let characters):
                self.charactersList.append(contentsOf: characters.data.results)
                self.charactersCount += self.limit

            case .failure(let error):
                self.delegate?.showError(error)
            }

            self.isDataLoading = false
        }
    }
}
