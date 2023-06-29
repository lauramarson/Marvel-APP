//
//  BaseView.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 15/06/23.
//

import UIKit

open class BaseView<M: BaseViewModel>: UIView, ViewCode, UpdatableModel {
    
    public var model: M
    
    public init(model: M, frame: CGRect = .zero) {
        self.model = model
        super.init(frame: frame)
        loadView()
        updateModel(model: model)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func addSubviews() { }
    
    open func addConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    open func additionalConfig() { }
    
    open func updateModel(model: M) {
        self.model = model
    }
}
