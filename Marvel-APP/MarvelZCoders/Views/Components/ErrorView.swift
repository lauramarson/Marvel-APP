//
//  ErrorView.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 16/11/22.
//

import UIKit

final class ErrorView: BaseView<ErrorViewModel> {
    
    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = model.title
        label.font = .cairo(.bold, size: 20)
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = model.message
        label.font = .cairo(.regular, size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font =  .cairo(.regular, size: 17)
        button.setTitle(model.buttonName, for: .normal)
        button.backgroundColor = UIColor(hex: "#43BB41ff")
        button.layer.cornerRadius = 15
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 27, bottom: 0, right: 27)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            messageLabel,
            button
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 41, left: 20, bottom: 0, right: 20)
        
        return stackView
    }()
    
    // MARK: - Action
    
    @objc
    private func didTap() {
        model.action()
    }

    // MARK: - ViewCode
    
    override func addSubviews() {
        super.addSubviews()
        addSubview(containerStackView)
    }
    
    override func addConstraints() {
        super.addConstraints()
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    override func additionalConfig() {
        self.backgroundColor = .white
    }
    
    override func updateModel(model: ErrorViewModel) {
        super.updateModel(model: model)
        titleLabel.text = model.title
        messageLabel.text = model.message
        button.setTitle(model.buttonName, for: .normal)
    }
}
