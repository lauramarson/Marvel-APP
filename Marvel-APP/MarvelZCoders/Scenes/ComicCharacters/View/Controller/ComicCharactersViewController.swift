//
//  ComicCharactersViewController.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 21/11/22.
//

import UIKit

final class ComicCharactersViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var comicCharactersView: ComicCharactersView = {
        let view = ComicCharactersView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    
    var viewModel: ComicCharactersViewModel?
    
    // MARK: - Initializers
    
    init(viewModel: ComicCharactersViewModel) {
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
        view = comicCharactersView
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
        self.navigationItem.title = "Personagens"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.preto ?? .black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        let backButton = UIBarButtonItem()
        backButton.title = " "
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

// MARK: - Comic Characters View Delegate

extension ComicCharactersViewController: ComicCharactersViewDelegate {
    func characterWasSelected(_ character: Character) {
        let descriptionVC = CharacterDescriptionViewController(character: character)
    
        navigationController?.pushViewController(descriptionVC, animated: true)
    }
}

// MARK: - Comic Characters View Model Delegate

extension ComicCharactersViewController: ComicCharactersViewModelDelegate {
    func comicCharactersViewModelDelegate(_ viewModel: ComicCharactersViewModel, didLoadCharactersList charactersList: [Character]) {
        comicCharactersView.loadCollectionView(with: charactersList)
    }
    
    func showError(_ error: NetworkError) {
        let errorVM = error.getErrorViewModel { [weak self] in
            self?.comicCharactersView.hideErrorView()
            self?.viewModel?.loadCharacters()
        }
        
        comicCharactersView.showErrorView(errorVM)
    }
}
