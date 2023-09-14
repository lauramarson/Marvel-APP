//
//  ComicCharactersViewModelProtocol.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 12/06/23.
//

import Foundation

protocol ComicCharactersViewModelDelegate: AnyObject {
    func comicCharactersViewModelDelegate(_ viewModel: ComicCharactersViewModel, didLoadCharactersList charactersList: [Character])
    func showError(_ error: NetworkError)
}

protocol ComicCharactersViewDelegate: AnyObject {
    func characterWasSelected(_ character: Character)
}
