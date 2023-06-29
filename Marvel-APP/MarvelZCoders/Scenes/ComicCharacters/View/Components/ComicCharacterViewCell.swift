//
//  ComicCharacterViewCell.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 21/11/22.
//

import UIKit

struct ComicCharacterModel: BaseViewModel {
    var name: String
    var pictureURL: URL?
}

final class ComicCharacterViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var model: ComicCharacterModel?
    
    // MARK: - UI Components
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .cairo(.semibold, size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.backgroundColor = UIColor.black.withAlphaComponent(0.66)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        
        return stackView
    }()
    
    // MARK: - Reuse ID
    
    static var reuseId: String {
        return String(describing: self)
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - ViewCode

extension ComicCharacterViewCell: ViewCode, OptionalUpdatableModel {
    
    func addSubviews() {
        self.contentView.addSubview(characterImageView)
        self.contentView.addSubview(labelStackView)
    }

    func addConstraints() {
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            labelStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            labelStackView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.13)
        ])
    }
    
    func updateModel(model: ComicCharacterModel?) {
        self.model = model
        nameLabel.text = model?.name
        characterImageView.kf.setImage(with: model?.pictureURL)
    }
}
