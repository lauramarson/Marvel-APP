//
//  CharacterDetailViewController.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 18/11/22.
//

import UIKit

final class CharacterDetailViewController: UIViewController {
    
    var viewModel: CharacterDetailViewModel?
    
    private lazy var errorView: ErrorView = {
        let errorView = ErrorView()
        return errorView
    }()

    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 26)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 11
        layout.itemSize = CGSize(width: 133, height: 200)
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ComicViewCell.self, forCellWithReuseIdentifier: ComicViewCell.reuseId)
        collectionView.register(CharacterHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CharacterHeaderView.reuseId)
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
    
//    private func presentErrorView(with error: ErrorViewType) {
//        self.view.addSubview(errorView)
//        errorView.errorType = error
//        
//        NSLayoutConstraint.activate([
//            errorView.topAnchor.constraint(equalTo: self.view.topAnchor),
//            errorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            errorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            errorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//        ])
//        
////        errorView.button.addTarget(self, action: #selector(errorViewButtonPressed), for: .touchUpInside)
//        errorView.fadeIn()
//        
//    }
    
    @objc private func errorViewButtonPressed() {
        errorView.fadeOut()
        errorView.removeFromSuperview()
        
        viewModel?.loadComics()
    }

}

extension CharacterDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.comicsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicViewCell.reuseId, for: indexPath) as? ComicViewCell else {
            fatalError("Não foi possível carregar Comic Cell")
        }

        cell.comic = viewModel?.comicsList[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CharacterHeaderView.reuseId, for: indexPath) as? CharacterHeaderView else {
                fatalError("Não foi possível carregar Character Header View")
            }

            header.character = viewModel?.character
            return header
        default:
            fatalError("Tipo de view não suportado: \(kind)")
        }
    }
}

extension CharacterDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }

        let detailVC = ComicCharactersViewController()

        let comic = viewModel.comicsList[indexPath.row]
        detailVC.viewModel = ComicCharactersViewModel(marvelAPI: MarvelAPI(), comic: comic)

        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension CharacterDetailViewController: UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)

        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
}

extension CharacterDetailViewController: CharacterDetailViewModelDelegate {
    func characterDetailViewModelDelegate(_ viewModel: CharacterDetailViewModel, didLoadComicsList comicsList: [Comic]) {
        collectionView.reloadData()
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
