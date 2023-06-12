//
//  ComicCharactersView.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 24/11/22.
//

import UIKit

class ComicCharactersView: UIView {
    
    // MARK: - UI Components
    
    private lazy var errorView = ErrorView()
    
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
    
    // MARK: - Properties
    
    private var viewModels: [Character] = []
    weak var delegate: ComicCharactersViewDelegate?

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func loadCollectionView(with viewModels: [Character]) {
        self.viewModels = viewModels
        collectionView.reloadData()
    }
    
    func showErrorView(_ error: ErrorViewModel) {
        addSubview(errorView)
        errorView.errorViewModel = error
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: self.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        errorView.fadeIn()
    }
    
    func hideErrorView() {
        errorView.fadeOut()
        errorView.removeFromSuperview()
        
        collectionView.reloadData()
    }

}

// MARK: - ViewCode

extension ComicCharactersView: ViewCode {
    func addSubviews() {
        addSubview(collectionView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: Collection View Data Source

extension ComicCharactersView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCharacterViewCell.reuseId, for: indexPath) as? ComicCharacterViewCell else {
            return UICollectionViewCell()
        }

        cell.character = viewModels[indexPath.row]
        
        return cell
    }
}

// MARK: - Collection View Delegate

extension ComicCharactersView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.characterWasSelected(viewModels[indexPath.row])
    }
}

// MARK: - Collection View Delegate Flow Layout

extension ComicCharactersView: UICollectionViewDelegateFlowLayout {
    
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
