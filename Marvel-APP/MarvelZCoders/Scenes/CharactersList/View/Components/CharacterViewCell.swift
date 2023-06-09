//
//  CharacterViewCell.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 10/11/22.
//

import UIKit
import Kingfisher

final class CharacterViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var character: Character? {
        didSet {
            guard let character = character else { return }
            nameLabel.text = character.name
            characterImageView.kf.setImage(with: character.pictureURL)
        }
    }
    
    // MARK: - UI Components
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .cairo(.semibold, size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            characterImageView,
            nameLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = .cinzaClaro
        stackView.layer.cornerRadius = 8
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
    
extension CharacterViewCell: ViewCode {
    
    func addSubviews() {
        self.contentView.addSubview(containerStackView)
    }

    func addConstraints() {
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            characterImageView.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor, multiplier: 0.75)
        ])
    }
    
    func additionalConfig() {
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.cinzaMedio?.cgColor
        self.contentView.layer.cornerRadius = 8
        
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.contentView.layer.shadowOpacity = 0.25
        self.contentView.layer.shadowRadius = 6
        
        self.contentView.clipsToBounds = false
        self.contentView.layer.masksToBounds = false
    }
}
