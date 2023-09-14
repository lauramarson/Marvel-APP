////
////  FailureCharacterDetailViewModelTests.swift
////  MarvelZCodersTests
////
////  Created by Laura Pinheiro Marson on 21/11/22.
////
//
//import XCTest
//@testable import MarvelZCoders
//
//final class FailureCharacterDetailViewModelTests: XCTestCase {
//    
//    var failureMarvelApi = FailureMarvelAPI()
//    var viewModel: CharacterDetailViewModel?
//
//    override func setUpWithError() throws {
//        failureMarvelApi = FailureMarvelAPI()
//        let character = Character(id: 5, name: "Character 5", description: "Descrição", thumbnail: nil)
//        viewModel = CharacterDetailViewModel(marvelAPI: failureMarvelApi, character: character)
//    }
//
//    func testLoadComicsWithFailure() throws {
//        let viewModel = try XCTUnwrap(viewModel)
//        
//        viewModel.loadComics()
//        
//        XCTAssertEqual(viewModel.comicsList.count, 0)
//        XCTAssertEqual(viewModel.comicsList.count, viewModel.comicsCount)
//    }
//}
