//
//  SuccessCharacterDetailViewModelTests.swift
//  MarvelZCodersTests
//
//  Created by Laura Pinheiro Marson on 21/11/22.
//

import XCTest
@testable import MarvelZCoders

final class SuccessCharacterDetailViewModelTests: XCTestCase {
    
    var successMarvelApi = SuccessMarvelAPI()
    var viewModel: CharacterDetailViewModel?

    override func setUpWithError() throws {       
        successMarvelApi = SuccessMarvelAPI()
        let character = Character(id: 5, name: "Character 5", description: "Descrição", thumbnail: nil)
        viewModel = CharacterDetailViewModel(marvelAPI: successMarvelApi, character: character)
    }

    func testLoadComicsWithSuccess() throws {
        let viewModel = try XCTUnwrap(viewModel)
        
        viewModel.loadComics()
        
        XCTAssertEqual(viewModel.comicsList.count, 20)
        XCTAssertEqual(viewModel.comicsList.count, viewModel.comicsCount)
    }

}
