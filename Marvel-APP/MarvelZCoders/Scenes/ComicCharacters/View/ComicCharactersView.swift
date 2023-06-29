//
//  ComicCharactersView.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 24/11/22.
//

import UIKit

struct ComicCharactersModel: BaseViewModel {
    var characters: [Character]
}

class ComicCharactersView: BaseView<ComicCharactersModel> {
    
    // MARK: - UI Components
    
    private lazy var errorView = ErrorView(model: .empty)
    
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
    
    weak var delegate: ComicCharactersViewDelegate?
    
    // MARK: - Methods
    
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

// MARK: - ViewCode

    override func addSubviews() {
        addSubview(collectionView)
    }
    
    override func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    override func updateModel(model: ComicCharactersModel) {
        super.updateModel(model: model)
        collectionView.reloadData()
    }
}

// MARK: Collection View Data Source

extension ComicCharactersView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCharacterViewCell.reuseId, for: indexPath) as? ComicCharacterViewCell else {
            return UICollectionViewCell()
        }

        let character = model.characters[indexPath.row]
        cell.updateModel(
            model: .init(
                name: character.name,
                pictureURL: character.pictureURL)
        )
        
        return cell
    }
}

// MARK: - Collection View Delegate

extension ComicCharactersView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.characterWasSelected(model.characters[indexPath.row])
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
