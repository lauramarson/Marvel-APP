//
//  ErrorView.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 16/11/22.
//

import UIKit

final class ErrorView: UIView {
    
    var errorType: ErrorViewType {
        didSet {
            titleLabel.text = errorType.title
            messageLabel.text = errorType.message
            button.setTitle(errorType.buttonName, for: .normal)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = errorType.title
        label.font = .cairo(.bold, size: 20)
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = errorType.message
        label.font = .cairo(.regular, size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font =  .cairo(.regular, size: 17)
        button.setTitle(errorType.buttonName, for: .normal)
        button.backgroundColor = UIColor(hex: "#43BB41ff")
        button.layer.cornerRadius = 15
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 27, bottom: 0, right: 27)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 32)
        ])
        
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
    
    init() {
        errorType = ErrorViewType(title: "", message: "", buttonName: "")
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        addViews()
        addConstraints()
    }

    private func addViews() {
        addSubview(containerStackView)
    }
    
    private func addConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
