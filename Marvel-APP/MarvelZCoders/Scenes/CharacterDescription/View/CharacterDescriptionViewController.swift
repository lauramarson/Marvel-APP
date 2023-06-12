//
//  CharacterInfoViewController.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 21/11/22.
//

import UIKit

final class CharacterDescriptionViewController: UIViewController {
    
    // MARK: - Properties
    
    private var character: Character?
    
    // MARK: - UI Components
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var alphaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.58)
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.font = .inder(.regular, size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializers
    
    init(character: Character) {
        super.init(nibName: nil, bundle: nil)
        self.character = character
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        initialSetup()
        fillCharacterInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.preto ?? .black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        addSubviews()
        addConstraints()
    }

    private func initialSetup() {
        title = "Personagens"
        
        let backButton = UIBarButtonItem()
        backButton.title = " "
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func fillCharacterInfo() {
        guard let character = character else { return }
        title = character.name
        descriptionLabel.text = validDescriptionFor(text: character.description)
        characterImageView.kf.setImage(with: character.pictureURL)
    }
    
    private func validDescriptionFor(text: String) -> String {
        if text.isEmpty {
            return "Este personagem não possui descrição."
        } else {
            return "\"\(text)\""
        }
    }
}

extension CharacterDescriptionViewController: ViewCode {
    func addSubviews() {
        view.addSubview(characterImageView)
        view.addSubview(alphaView)
        view.addSubview(descriptionLabel)
    }

    func addConstraints() {

        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            alphaView.topAnchor.constraint(equalTo: self.view.topAnchor),
            alphaView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            alphaView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            alphaView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 21),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -22)
        ])
    }
}
