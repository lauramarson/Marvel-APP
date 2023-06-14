//
//  ErrorView.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 16/11/22.
//

import UIKit

final class ErrorView: UIView {
    
    // MARK: - Properties
    
    var errorViewModel: ErrorViewModel {
        didSet {
            titleLabel.text = errorViewModel.title
            messageLabel.text = errorViewModel.message
            button.setTitle(errorViewModel.buttonName, for: .normal)
        }
    }
    
    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = errorViewModel.title
        label.font = .cairo(.bold, size: 20)
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = errorViewModel.message
        label.font = .cairo(.regular, size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font =  .cairo(.regular, size: 17)
        button.setTitle(errorViewModel.buttonName, for: .normal)
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
    
    // MARK: - Initializers
    
    init() {
        errorViewModel = ErrorViewModel(title: "", message: "", buttonName: "", action: { /* Intentionally Unimplemented */})
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        loadView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc
    private func didTap() {
        errorViewModel.action()
    }
}

    // MARK: - ViewCode
    
extension ErrorView: ViewCode {
    
    func addSubviews() {
        addSubview(containerStackView)
    }
    
    func addConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func additionalConfig() {
        self.backgroundColor = .white
    }
}
