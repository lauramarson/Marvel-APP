//
//  CharacterHeaderView.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 19/11/22.
//

import UIKit

final class CharacterHeaderView: UICollectionReusableView {
    
    var character: Character? {
        didSet {
            guard let character = character else { return }
            characterImageView.kf.setImage(with: character.pictureURL)
            character.description == "" ? (descriptionLabel.text = "Sem descrição disponível") : (descriptionLabel.text = "\"\(character.description)\"")
        }
    }
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.font = .inder(.regular, size: 15)
        label.textColor = .preto
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            characterImageView,
            descriptionLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 6
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 17, bottom: 10, right: 26)
        
        return stackView
    }()
    
    static var reuseId: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addViews()
        addConstraints()
    }
    
    private func addViews() {
        self.addSubview(containerStackView)
    }

    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            characterImageView.heightAnchor.constraint(equalToConstant: 112),
            characterImageView.widthAnchor.constraint(equalTo: characterImageView.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
