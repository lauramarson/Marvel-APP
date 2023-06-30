//
//  CharactersListViewController.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 10/11/22.
//

import UIKit

final class CharactersListViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var charactersListView: CharactersListView = {
        let view = CharactersListView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    
    private var viewModel: CharactersListViewModel?
    var isSearching: Bool = false
    
    // MARK: - Initializers
    
    init(viewModel: CharactersListViewModel) {
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
        view = charactersListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: - Methods
    
    private func initialSetup() {
        setupNavBar()
        
        viewModel?.delegate = self
        viewModel?.loadCharacters()
    }
    
    private func setupNavBar() {
        self.navigationController?.view.tintColor = UIColor(hex: "#909497ff")
        self.navigationItem.title = "Marvel Heroes"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.preto ?? .black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        let backButton = UIBarButtonItem()
        backButton.title = " "
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

// MARK: - Characters List View Delegate

extension CharactersListViewController: CharactersListViewDelegate {
    func characterWasSelected(_ character: Character) {
        let characterDetailViewModel = CharacterDetailViewModel(marvelAPI: MarvelAPI(), character: character)
        let detailVC = CharacterDetailViewController(viewModel: characterDetailViewModel)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewScrolled(offset: Int) {
        guard let viewModel = viewModel else { return }
        if !viewModel.isDataLoading {
            isSearching ? viewModel.searchForCharacters(offset: offset) : viewModel.loadCharacters()
        }
    }
    
    func searchForCharacters(startingWith text: String) {
        viewModel?.searchForCharacters(startingWith: text)
    }
}

// MARK: - Characters List View Model Delegate

extension CharactersListViewController: CharactersListViewModelDelegate {
 
    func charactersListViewModelDelegate(_ viewModel: CharactersListViewModel, didLoadCharactersList charactersList: [Character]) {
        charactersListView.loadCollectionView(with: charactersList)
    }
    
    func charactersListViewModelDelegate(_ viewModel: CharactersListViewModel, didSearchForCharacters charactersList: [Character]) {
        DispatchQueue.main.async { [weak self] in
            guard let isSearching = self?.isSearching, isSearching else { return }
            
            if charactersList.isEmpty {
                let error = NetworkError.emptySearch.getErrorViewModel { [weak self] in
                    self?.isSearching = false
                    self?.charactersListView.hideErrorView()
                }
                
                self?.charactersListView.showErrorView(error)
            } else {
                self?.charactersListView.loadCollectionView(with: charactersList)
            }
        }
    }
    
    func showError(_ error: NetworkError) {
        let errorVM = error.getErrorViewModel { [weak self] in
            self?.charactersListView.hideErrorView()
            self?.viewModel?.loadCharacters()
        }
        
        charactersListView.showErrorView(errorVM)
    }
}
