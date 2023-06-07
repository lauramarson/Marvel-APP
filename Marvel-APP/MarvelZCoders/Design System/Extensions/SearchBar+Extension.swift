//
//  SearchBar+Extension.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 11/11/22.
//

import UIKit

extension UISearchBar {
    func customSearchBar() {
        self.barTintColor = UIColor.white
        self.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.setImage(UIImage(named: "SearchIcon"), for: .search, state: .normal)

        self.searchTextField.backgroundColor = .clear
        self.backgroundColor = UIColor(hex: "#F2F2F2ff")
        self.layer.cornerRadius = 10
    }
}
