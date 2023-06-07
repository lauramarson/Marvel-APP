//
//  FailureComicCharactersViewModelTests.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 22/11/22.
//

import XCTest
@testable import MarvelZCoders

final class FailureComicCharactersViewModelTests: XCTestCase {
    
    var failureMarvelApi = FailureMarvelAPI()
    var viewModel: ComicCharactersViewModel?

    override func setUpWithError() throws {
        failureMarvelApi = FailureMarvelAPI()
        let comic = Comic(id: 9, title: "Comic 9", thumbnail: nil)
        viewModel = ComicCharactersViewModel(marvelAPI: failureMarvelApi, comic: comic)
    }

    func testLoadCharactersWithFailure() throws {
        let viewModel = try XCTUnwrap(viewModel)
        
        viewModel.loadCharacters()
        
        XCTAssertEqual(viewModel.charactersList.count, 0)
        XCTAssertEqual(viewModel.charactersList.count, viewModel.charactersCount)
    }

}
