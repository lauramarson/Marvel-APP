//
//  SuccessComicCharactersViewModelTests.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 21/11/22.
//

import XCTest
@testable import MarvelZCoders

final class SuccessComicCharactersViewModelTests: XCTestCase {
    
    var successMarvelApi = SuccessMarvelAPI()
    var viewModel: ComicCharactersViewModel?

    override func setUpWithError() throws {
        successMarvelApi = SuccessMarvelAPI()
        let comic = Comic(id: 9, title: "Comic 9", thumbnail: nil)
        viewModel = ComicCharactersViewModel(marvelAPI: successMarvelApi, comic: comic)
    }

    func testLoadCharactersWithSuccess() throws {
        let viewModel = try XCTUnwrap(viewModel)
        
        viewModel.loadCharacters()
        
        XCTAssertEqual(viewModel.charactersList.count, 20)
        XCTAssertEqual(viewModel.charactersList.count, viewModel.charactersCount)
    }

}
