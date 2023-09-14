//
//  FailureCharacterDetailViewModelTests.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 21/11/22.
//

import XCTest
@testable import MarvelZCoders

final class FailureCharacterDetailViewModelTests: XCTestCase {
    
    var failureMarvelApi: NetworkManagerFailureMock!
    var comicsService: FetchComicsService!
    var sut: CharacterDetailViewModel!

    override func setUpWithError() throws {
        failureMarvelApi = NetworkManagerFailureMock()
        comicsService = FetchComicsService(apiManager: failureMarvelApi)
        let character = Character(id: 5, name: "Character 5", description: "Descrição", thumbnail: nil)
        sut = CharacterDetailViewModel(comicsService: comicsService, character: character)
    }

    func testLoadComicsWithFailure() throws {
        sut.loadComics()
        
        XCTAssertEqual(sut.comicsList.count, 0)
        XCTAssertEqual(sut.comicsList.count, sut.comicsCount)
    }
}
