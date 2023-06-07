//
//  ComicCharactersViewController.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 21/11/22.
//

import UIKit

final class ComicCharactersViewController: UIViewController {
    
    var viewModel: ComicCharactersViewModel?
    
//    var customView: ComicCharactersViewScreen {
//        return view as! ComicCharactersViewScreen
//    }
    
    private lazy var errorView: ErrorView = {
        let errorView = ErrorView()
        return errorView
    }()
    
//    override func loadView() {
//        let customView = ComicCharactersViewScreen()
//        customView.setupCollectionViewProtocols(delegate: self, dataSource: self)
//        view = customView
//    }
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.itemSize = CGSize(width: 133, height: 200)
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ComicCharacterViewCell.self, forCellWithReuseIdentifier: ComicCharacterViewCell.reuseId)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        initialSetup()
    }
    
    private func configViews() {
        addViews()
        addConstraints()
    }

    private func addViews() {
        view.addSubview(collectionView)
    }
    
    private func addConstraints() {

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
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
    
    private func presentErrorView(with error: ErrorViewType) {
        self.view.addSubview(errorView)
        errorView.errorType = error
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: self.view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        errorView.button.addTarget(self, action: #selector(errorViewButtonPressed), for: .touchUpInside)
        errorView.fadeIn()
    }
    
    @objc private func errorViewButtonPressed() {
        errorView.fadeOut()
        errorView.removeFromSuperview()
        
        viewModel?.loadCharacters()
    }
}
    
// MARK: UICollectionViewDataSource

extension ComicCharactersViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.charactersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCharacterViewCell.reuseId, for: indexPath) as? ComicCharacterViewCell else {
            fatalError("Não foi possível carregar Comic Character View Cell")
        }
        
        let character = viewModel?.charactersList[indexPath.row]
        cell.character = character
        
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension ComicCharactersViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let descriptionVC = CharacterDescriptionViewController()
        
        descriptionVC.character = viewModel?.charactersList[indexPath.row]
        navigationController?.pushViewController(descriptionVC, animated: true)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ComicCharactersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("Não foi possível carregar o flow layout")
        }

        let heightProportion: CGFloat = 1.5
        let itemsPerLine: CGFloat = 2

        let sectionMargins = flowLayout.sectionInset
        let itemsSpacing = flowLayout.minimumInteritemSpacing

        let utilWidth = collectionView.bounds.width - (sectionMargins.left + sectionMargins.right) - itemsSpacing * (itemsPerLine - 1)
        let itemWidth = utilWidth / itemsPerLine

        return CGSize(width: itemWidth, height: itemWidth * heightProportion)
    }
}

// MARK: ComicCharactersViewModelDelegate

extension ComicCharactersViewController: ComicCharactersViewModelDelegate {
    func comicCharactersViewModelDelegate(_ viewModel: ComicCharactersViewModel, didLoadCharactersList charactersList: [Character]) {
        collectionView.reloadData()
    }
    
    func noInternetConnectionDelegate() {
        let error = ErrorViewType(title: "Ocorreu um erro", message: "Por gentileza verifique se você está com a internet ativa, caso esteja, tente novamente através do botão abaixo.", buttonName: "Tentar novamente")
        presentErrorView(with: error)
    }
    
    func unableToFetchDataDelegate() {
        let error = ErrorViewType(title: "Ocorreu um erro", message: "No momento, não foi possível carregar os dados. Tente novamente mais tarde.", buttonName: "Tentar novamente")
        presentErrorView(with: error)
    }
    
}
