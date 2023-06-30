//
//  CharacterDetailViewModelProtocol.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 12/06/23.
//

import Foundation

protocol CharacterDetailViewDelegate: AnyObject {
    func comicWasSelected(_ comic: Comic)
}

protocol CharacterDetailViewModelDelegate: AnyObject {
    func characterDetailViewModelDelegate(_ viewModel: CharacterDetailViewModel, didLoadComicsList comicsList: [Comic])
    func showError(_ error: NetworkError)
}
