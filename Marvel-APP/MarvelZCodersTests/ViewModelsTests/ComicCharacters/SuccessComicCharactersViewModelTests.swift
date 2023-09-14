//
//  SuccessComicCharactersViewModelTests.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 21/11/22.
//

import XCTest
@testable import MarvelZCoders

final class SuccessComicCharactersViewModelTests: XCTestCase {
    
    var successMarvelApi: MarvelNetworkManagerSuccessMock!
    var charactersService: FetchCharactersService!
    var sut: ComicCharactersViewModel!

    override func setUpWithError() throws {
        successMarvelApi = MarvelNetworkManagerSuccessMock()
        charactersService = FetchCharactersService(apiManager: successMarvelApi)
        let comic = Comic(id: 9, title: "Comic 9", thumbnail: nil)
        sut = ComicCharactersViewModel(charactersService: charactersService, comic: comic)
    }

    func testLoadCharactersWithSuccess() throws {
        sut.loadCharacters()
        
        XCTAssertEqual(sut.charactersList.count, 20)
        XCTAssertEqual(sut.charactersList.count, sut.charactersCount)
    }

}
