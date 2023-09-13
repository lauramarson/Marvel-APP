//
//  CharactersListViewModel.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 14/11/22.
//

import Foundation

class CharactersListViewModel {
    private let limit = 20
    private(set) var charactersCount = 0
    private(set) var isDataLoading = false
    var searchText = ""
    var searchCalls = 0
    var searchsCompleted = 0
    
    weak var delegate: CharactersListViewModelDelegate?
    
    private let charactersService: FetchCharactersProtocol
    
    private(set) var charactersList: [Character] = [] {
        didSet {
            delegate?.charactersListViewModelDelegate(self, didLoadCharactersList: charactersList)
        }
    }
    
    private(set) var searchedCharacters: [Character] = []

    init(charactersService: FetchCharactersProtocol = FetchCharactersService()) {
        self.charactersService = charactersService
    }
    
    func loadCharacters() {
        isDataLoading = true
        
        charactersService.fetchCharactersList(offset: charactersCount) { [weak self] result in
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
    
    func searchForCharacters(startingWith text: String? = nil, offset: Int = 0) {
        isDataLoading = true
        searchCalls += 1
        
        if let text = text {
            if searchText != text {
                searchedCharacters = []
            }
            searchText = text.lowercased().capitalized
        }
        
        charactersService.searchForCharacters(name: searchText, offset: offset) { [weak self] result in
            guard let self = self else { return }

            self.searchsCompleted += 1

            switch result {
            case .success(let characters):

                let charactersResult = characters.data.results

                if !charactersResult.isEmpty {
                    guard let lastResultName = charactersResult.last?.name, lastResultName.starts(with: self.searchText) else { return }
                }

                guard self.searchsCompleted == self.searchCalls else { return }

                offset > 0 ? self.searchedCharacters.append(contentsOf: charactersResult) : (self.searchedCharacters = charactersResult)

                self.delegate?.charactersListViewModelDelegate(self, didSearchForCharacters: self.searchedCharacters)

            case .failure(let error):
                self.delegate?.showError(error)
            }

            self.isDataLoading = false
        }
    }
}
