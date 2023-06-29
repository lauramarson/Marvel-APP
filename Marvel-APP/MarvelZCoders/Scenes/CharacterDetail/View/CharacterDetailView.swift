//
//  CharacterDetailView.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 12/06/23.
//

import UIKit

class CharacterDetailView: UIView {
    
    // MARK: - UI Components
    
    private lazy var errorView = ErrorView(model: .empty)
    
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
    
    // MARK: - Properties
    
    private var characterViewModel: Character?
    private var comicsViewModels: [Comic] = []
    weak var delegate: CharacterDetailViewDelegate?
    
    // MARK: - Initializers
    
    required init(character: Character?) {
        super.init(frame: .zero)
        characterViewModel = character
        loadView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func loadCollectionView(with viewModels: [Comic]) {
        self.comicsViewModels = viewModels
        collectionView.reloadData()
    }
    
    func showErrorView(_ error: ErrorViewModel) {
        addSubview(errorView)
        errorView.updateModel(model: error)
        
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

extension CharacterDetailView: ViewCode {
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

// MARK: - Collection View Data Source

extension CharacterDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicsViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicViewCell.reuseId, for: indexPath) as? ComicViewCell else {
            return UICollectionViewCell()
        }

        cell.comic = comicsViewModels[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CharacterHeaderView.reuseId, for: indexPath) as? CharacterHeaderView else {
                return UICollectionReusableView()
            }

            header.character = characterViewModel
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - Collection View Delegate

extension CharacterDetailView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.comicWasSelected(comicsViewModels[indexPath.row])
    }
}

// MARK: - Collection View Delegate Flow Layout

extension CharacterDetailView: UICollectionViewDelegateFlowLayout {
    
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
