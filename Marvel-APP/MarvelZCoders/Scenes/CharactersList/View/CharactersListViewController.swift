//
//  CharactersListViewController.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 10/11/22.
//

import UIKit

final class CharactersListViewController: UIViewController {
    
    var viewModel: CharactersListViewModel?
    var isSearching: Bool = false
    
    private lazy var errorView: ErrorView = {
        let errorView = ErrorView()
        return errorView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.customSearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 20
        layout.itemSize = CGSize(width: 130, height: 140)
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CharacterViewCell.self, forCellWithReuseIdentifier: CharacterViewCell.reuseId)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        initialSetup()
    }
    
    private func configViews() {
        view.backgroundColor = .systemBackground
        addViews()
        addConstraints()
    }

    private func addViews() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    private func addConstraints() {

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
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
        self.navigationItem.title = "Marvel Heroes"
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
            errorView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
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
        
        if !isSearching {
            viewModel?.loadCharacters()
        } else {
            isSearching = false
            collectionView.reloadData()
            searchBar.text = ""
        }
    }

}

extension CharactersListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return isSearching ? viewModel.searchedCharacters.count : viewModel.charactersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterViewCell.reuseId, for: indexPath) as? CharacterViewCell else {
            fatalError("Não foi possível carregar célula do personagem")
        }
        let character = (isSearching ? viewModel?.searchedCharacters[indexPath.row] : viewModel?.charactersList[indexPath.row])
        cell.character = character
        return cell
    }
}

extension CharactersListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        
        let detailVC = CharacterDetailViewController()
                
        let character = (isSearching ? viewModel.searchedCharacters[indexPath.row] : viewModel.charactersList[indexPath.row])
        detailVC.viewModel = CharacterDetailViewModel(marvelAPI: MarvelAPI(), character: character)

        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ((collectionView.contentOffset.y + collectionView.frame.size.height) >= collectionView.contentSize.height - 200) {
            guard let viewModel = viewModel else { return }
            if !viewModel.isDataLoading {
                if isSearching {
                    let offset = collectionView.numberOfItems(inSection: 0)
                    viewModel.searchForCharacters(offset: offset)
                } else {
                    viewModel.loadCharacters()
                }
            }
        }
    }
}

extension CharactersListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("Não foi possível carregar o flow layout")
        }
        
        let heightProportion: CGFloat = 1.077
        let itemsPerLine: CGFloat = 2
        
        let sectionMargins = flowLayout.sectionInset
        let itemsSpacing = flowLayout.minimumInteritemSpacing
        
        let utilWidth = collectionView.bounds.width - (sectionMargins.left + sectionMargins.right) - itemsSpacing * (itemsPerLine - 1)
        let itemWidth = utilWidth / itemsPerLine
        
        return CGSize(width: itemWidth, height: itemWidth * heightProportion)
    }
    
}

extension CharactersListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Debounce<String>.input(searchText, comparedAgainst: searchBar.text ?? "") { [weak self] _ in
            
            self?.isSearching = true

            if searchBar.text == "" {
                self?.resetSearchbar(searchBar)
                self?.errorView.removeFromSuperview()
            } else {
                self?.errorView.removeFromSuperview()
                self?.viewModel?.searchForCharacters(startingWith: searchText)
            }
        }
    }
    
    func resetSearchbar(_ searchBar: UISearchBar) {
        isSearching = false
        collectionView.reloadData()
        searchBar.resignFirstResponder()
    }
}


extension CharactersListViewController: CharactersListViewModelDelegate {
    func noInternetConnectionDelegate() {
        let error = ErrorViewType(title: "Ocorreu um erro", message: "Por gentileza verifique se você está com a internet ativa, caso esteja, tente novamente através do botão abaixo.", buttonName: "Tentar novamente")
        presentErrorView(with: error)
    }
    
    func charactersListViewModelDelegate(_ viewModel: CharactersListViewModel, didLoadCharactersList charactersList: [Character]) {
        errorView.removeFromSuperview()
        collectionView.reloadData()
    }
    
    func charactersListViewModelDelegate(_ viewModel: CharactersListViewModel, didSearchForCharacters charactersList: [Character]) {
        DispatchQueue.main.async { [weak self] in
            if let isSearching = self?.isSearching, isSearching {
                if charactersList.isEmpty {
                    let error = ErrorViewType(title: "Oops...", message: "Infelizmente, não encontramos personagens com esse nome.", buttonName: "Ok")
                    self?.presentErrorView(with: error)
                } else {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    func unableToFetchDataDelegate() {
        let error = ErrorViewType(title: "Ocorreu um erro", message: "No momento, não foi possível carregar os dados. Tente novamente mais tarde.", buttonName: "Tentar novamente")
        presentErrorView(with: error)
    }
}
