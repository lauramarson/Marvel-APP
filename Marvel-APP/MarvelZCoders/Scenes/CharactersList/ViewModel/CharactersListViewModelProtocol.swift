//
//  CharactersListViewModelProtocol.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 07/06/23.
//

import Foundation

protocol CharactersListViewDelegate: AnyObject {
    var isSearching: Bool { get set }
    func characterWasSelected(_ character: Character)
    func scrollViewScrolled(offset: Int)
    func searchForCharacters(startingWith text: String)
}

protocol CharactersListViewModelDelegate: AnyObject {
    func charactersListViewModelDelegate(_ viewModel: CharactersListViewModel, didLoadCharactersList charactersList: [Character])
    func charactersListViewModelDelegate(_ viewModel: CharactersListViewModel, didSearchForCharacters charactersList: [Character])
    func noInternetConnectionDelegate()
    func unableToFetchDataDelegate()
}
