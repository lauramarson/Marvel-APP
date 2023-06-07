//
//  FailureCharactersListViewModelTests.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 17/11/22.
//

import XCTest
@testable import MarvelZCoders

final class FailureCharactersListViewModelTests: XCTestCase {
    
    var failureMarvelApi = FailureMarvelAPI()
    var viewModel: CharactersListViewModel?

    override func setUpWithError() throws {
        failureMarvelApi = FailureMarvelAPI()
        viewModel = CharactersListViewModel(marvelAPI: failureMarvelApi)
    }

    func testLoadCharactersWithFailure() throws {
        let viewModel = try XCTUnwrap(viewModel)
        
        viewModel.loadCharacters()
        
        XCTAssertEqual(viewModel.charactersList.count, 0)
        XCTAssertEqual(viewModel.charactersList.count, viewModel.charactersCount)
    }
    
    func testSearchForCharactersWithFailure() throws {
        
        let viewModel = try XCTUnwrap(viewModel)
        
        viewModel.searchForCharacters(startingWith: "wol")
        
        XCTAssertEqual(viewModel.searchedCharacters.count, 0)
    }

}
