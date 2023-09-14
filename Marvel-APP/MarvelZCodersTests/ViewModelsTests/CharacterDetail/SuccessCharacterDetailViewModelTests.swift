//
//  SuccessCharacterDetailViewModelTests.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 21/11/22.
//

import XCTest
@testable import MarvelZCoders

final class SuccessCharacterDetailViewModelTests: XCTestCase {

    var successMarvelApi: MarvelNetworkManagerSuccessMock!
    var comicsService: FetchComicsService!
    var sut: CharacterDetailViewModel!

    override func setUpWithError() throws {
        successMarvelApi = MarvelNetworkManagerSuccessMock()
        comicsService = FetchComicsService(apiManager: successMarvelApi)
        let character = Character(id: 5, name: "Character 5", description: "Descrição", thumbnail: nil)
        sut = CharacterDetailViewModel(comicsService: comicsService, character: character)
    }

    func testLoadComicsWithSuccess() throws {
        sut.loadComics()

        XCTAssertEqual(sut.comicsList.count, 20)
        XCTAssertEqual(sut.comicsList.count, sut.comicsCount)
    }

}
