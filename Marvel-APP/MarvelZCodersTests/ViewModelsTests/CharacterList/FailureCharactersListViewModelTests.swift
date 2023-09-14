//
//  FailureCharactersListViewModelTests.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 17/11/22.
//

import XCTest
@testable import MarvelZCoders

final class FailureCharactersListViewModelTests: XCTestCase {
    
    var failureMarvelApi: NetworkManagerFailureMock!
    var charactersService: FetchCharactersService!
    var sut: CharactersListViewModel!

    override func setUpWithError() throws {
        failureMarvelApi = NetworkManagerFailureMock()
        charactersService = FetchCharactersService(apiManager: failureMarvelApi)
        sut = CharactersListViewModel(charactersService: charactersService)
    }

    func testLoadCharactersWithFailure() throws {
        sut.loadCharacters()
        
        XCTAssertEqual(sut.charactersList.count, 0)
        XCTAssertEqual(sut.charactersList.count, sut.charactersCount)
    }
    
    func testSearchForCharactersWithFailure() throws {
        sut.searchForCharacters(startingWith: "wol")
        
        XCTAssertEqual(sut.searchedCharacters.count, 0)
    }

}
