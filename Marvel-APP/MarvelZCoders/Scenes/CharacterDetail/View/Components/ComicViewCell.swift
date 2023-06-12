//
//  ComicViewCell.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 19/11/22.
//

import UIKit

final class ComicViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var comic: Comic? {
        didSet {
            guard let comic = comic else { return }
            titleLabel.text = comic.title
            comicImageView.kf.setImage(with: comic.pictureURL)
        }
    }
    
    // MARK: - UI Components
    
    private lazy var comicImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .cairo(.semibold, size: 12)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.backgroundColor = UIColor.black.withAlphaComponent(0.66)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
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

extension ComicViewCell: ViewCode {
    func addSubviews() {
        self.contentView.addSubview(comicImageView)
        self.contentView.addSubview(labelStackView)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            comicImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            comicImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            comicImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            comicImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            labelStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            labelStackView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.245)
        ])
    }
}
