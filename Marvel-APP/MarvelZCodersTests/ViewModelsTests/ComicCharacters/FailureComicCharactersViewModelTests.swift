//
//  FailureComicCharactersViewModelTests.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 22/11/22.
//

import XCTest
@testable import MarvelZCoders

final class FailureComicCharactersViewModelTests: XCTestCase {
    
    var failureMarvelApi: NetworkManagerFailureMock!
    var charactersService: FetchCharactersService!
    var sut: ComicCharactersViewModel!

    override func setUpWithError() throws {
        failureMarvelApi = NetworkManagerFailureMock()
        charactersService = FetchCharactersService(apiManager: failureMarvelApi)
        let comic = Comic(id: 9, title: "Comic 9", thumbnail: nil)
        sut = ComicCharactersViewModel(charactersService: charactersService, comic: comic)
    }

    func testLoadCharactersWithFailure() throws {
        sut.loadCharacters()
        
        XCTAssertEqual(sut.charactersList.count, 0)
        XCTAssertEqual(sut.charactersList.count, sut.charactersCount)
    }

}
