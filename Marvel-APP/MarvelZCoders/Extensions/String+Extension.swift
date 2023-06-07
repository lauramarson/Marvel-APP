//
//  String+Extension.swift
//  MarvelZCoders
//
//  Created by Laura Pinheiro Marson on 14/11/22.
//

import Foundation
import CryptoKit

extension String  {
    var md5: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
