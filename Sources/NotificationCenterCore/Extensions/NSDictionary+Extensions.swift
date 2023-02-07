//
//  NSDictionary+Extensions.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import Foundation

extension NSDictionary {
    func int(forKey key: String) -> Int? {
        object(forKey: key) as? Int
    }
    
    func string(forKey key: String) -> String? {
        object(forKey: key) as? String
    }
}
