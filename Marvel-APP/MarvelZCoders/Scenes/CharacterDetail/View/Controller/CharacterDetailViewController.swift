//
//  CharacterDetailViewController.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 18/11/22.
//

import UIKit

final class CharacterDetailViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var characterDetailView: CharacterDetailView = {
        let view = CharacterDetailView(character: viewModel?.character)
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    
    var viewModel: CharacterDetailViewModel?
    
    // MARK: - Initializers
    
    init(viewModel: CharacterDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = characterDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: - Methods
    
    private func initialSetup() {
        setupNavBar()
        
        viewModel?.delegate = self
        viewModel?.loadComics()
    }
    
    private func setupNavBar() {
        self.navigationController?.view.tintColor = UIColor(hex: "#909497ff")
        self.navigationItem.title = viewModel?.character?.name
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.preto ?? .black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        let backButton = UIBarButtonItem()
        backButton.title = " "
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

// MARK: - Character Detail View Delegate

extension CharacterDetailViewController: CharacterDetailViewDelegate {
    func comicWasSelected(_ comic: Comic) {
        let comicViewModel = ComicCharactersViewModel(marvelAPI: MarvelAPI(), comic: comic)
        let detailVC = ComicCharactersViewController(viewModel: comicViewModel)

        navigationController?.pushViewController(detailVC, animated: true)
    }

}

// MARK: - Character Detail View Model Delegate

extension CharacterDetailViewController: CharacterDetailViewModelDelegate {
    func characterDetailViewModelDelegate(_ viewModel: CharacterDetailViewModel, didLoadComicsList comicsList: [Comic]) {
        characterDetailView.loadCollectionView(with: comicsList)
    }
    
    func noInternetConnectionDelegate() {
        let error = ErrorViewType.noInternetConnection.getErrorViewModel { [weak self] in
            self?.characterDetailView.hideErrorView()
            self?.viewModel?.loadComics()
        }
        
        characterDetailView.showErrorView(error)
    }
    
    func unableToFetchDataDelegate() {
        let error = ErrorViewType.unableToFetchData.getErrorViewModel { [weak self] in
            self?.characterDetailView.hideErrorView()
            self?.viewModel?.loadComics()
        }
        
        characterDetailView.showErrorView(error)
    }
}
