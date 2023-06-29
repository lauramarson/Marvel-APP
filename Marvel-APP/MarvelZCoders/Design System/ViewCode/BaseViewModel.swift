//
//  BaseViewModel.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 15/06/23.
//

import Foundation

public protocol BaseViewModel { }

public struct EmptyModel: BaseViewModel { }

public protocol UpdatableModel {
    associatedtype M: BaseViewModel
    
    var model: M { get set }
    
    func updateModel(model: M)
}

public protocol OptionalUpdatableModel {
    associatedtype M: BaseViewModel
    
    var model: M? { get set }
    
    func updateModel(model: M?)
}
