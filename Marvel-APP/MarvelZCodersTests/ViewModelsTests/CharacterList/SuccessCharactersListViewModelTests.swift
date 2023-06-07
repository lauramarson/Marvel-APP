//
//  MarvelZCodersTests.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 15/11/22.
//

import XCTest
@testable import MarvelZCoders

final class SuccessCharactersListViewModelTests: XCTestCase {
    
    var successMarvelApi = SuccessMarvelAPI()
    var viewModel: CharactersListViewModel?

    override func setUpWithError() throws {       
        successMarvelApi = SuccessMarvelAPI()
        viewModel = CharactersListViewModel(marvelAPI: successMarvelApi)
    }

    func testLoadCharactersWithSuccess() throws {
        
        let viewModel = try XCTUnwrap(viewModel)
        
        viewModel.loadCharacters()
        
        XCTAssertEqual(viewModel.charactersList.count, 20)
        XCTAssertEqual(viewModel.charactersList.count, viewModel.charactersCount)
    }
    
    func testSearchForCharactersWithSuccess() throws {
        
        let viewModel = try XCTUnwrap(viewModel)
        
        viewModel.searchForCharacters(startingWith: "wol")
        
        XCTAssertEqual(viewModel.searchedCharacters.last?.name, "Wol")
    }

}
