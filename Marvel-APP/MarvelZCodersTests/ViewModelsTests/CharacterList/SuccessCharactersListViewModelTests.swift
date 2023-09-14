//
//  MarvelZCodersTests.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 15/11/22.
//

import XCTest
@testable import MarvelZCoders

final class SuccessCharactersListViewModelTests: XCTestCase {
    
    var successMarvelApi: MarvelNetworkManagerSuccessMock!
    var charactersService: FetchCharactersService!
    var sut: CharactersListViewModel!

    override func setUpWithError() throws {       
        successMarvelApi = MarvelNetworkManagerSuccessMock()
        charactersService = FetchCharactersService(apiManager: successMarvelApi)
        sut = CharactersListViewModel(charactersService: charactersService)
    }

    func testLoadCharactersWithSuccess() throws {
        sut.loadCharacters()
        
        XCTAssertEqual(sut.charactersList.count, 20)
        XCTAssertEqual(sut.charactersList.count, sut.charactersCount)
    }
    
    func testSearchForCharactersWithSuccess() throws {
        sut.searchForCharacters(startingWith: "wol")
        
        XCTAssertEqual(sut.searchedCharacters.last?.name, "Wol")
    }

}
