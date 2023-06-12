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
    
//    override func loadView() {
//        let customView = ComicCharactersViewScreen()
//        customView.setupCollectionViewProtocols(delegate: self, dataSource: self)
//        view = customView
//    }
    
//    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//        layout.minimumLineSpacing = 20
//        layout.minimumInteritemSpacing = 20
//        layout.itemSize = CGSize(width: 133, height: 200)
//        return layout
//    }()
//
//    lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.register(ComicCharacterViewCell.self, forCellWithReuseIdentifier: ComicCharacterViewCell.reuseId)
//        return collectionView
//    }()
    
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

// MARK: Comic Characters View Delegate

extension ComicCharactersViewController: ComicCharactersViewDelegate {
    func characterWasSelected(_ character: Character) {
        let descriptionVC = CharacterDescriptionViewController()
        
        descriptionVC.character = character
        navigationController?.pushViewController(descriptionVC, animated: true)
    }
}

// MARK: Comic Characters View Model Delegate

extension ComicCharactersViewController: ComicCharactersViewModelDelegate {
    func comicCharactersViewModelDelegate(_ viewModel: ComicCharactersViewModel, didLoadCharactersList charactersList: [Character]) {
        comicCharactersView.loadCollectionView(with: charactersList)
    }
    
    func noInternetConnectionDelegate() {
//        let error = ErrorViewType(title: "Ocorreu um erro", message: "Por gentileza verifique se você está com a internet ativa, caso esteja, tente novamente através do botão abaixo.", buttonName: "Tentar novamente")
//        presentErrorView(with: error)
    }
    
    func unableToFetchDataDelegate() {
//        let error = ErrorViewType(title: "Ocorreu um erro", message: "No momento, não foi possível carregar os dados. Tente novamente mais tarde.", buttonName: "Tentar novamente")
//        presentErrorView(with: error)
    }
    
}
