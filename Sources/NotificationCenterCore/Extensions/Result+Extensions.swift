//
//  Result+Extensions.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import Foundation

extension Result {
    var success: Success? {
        switch self {
        case .success(let success):
            return success
        case .failure:
            return .none
        }
    }
    
    var error: Error? {
        switch self {
        case .success:
            return .none
        case .failure(let failure):
            return failure
        }
    }
}
