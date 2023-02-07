//
//  NotificationStyle.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import Foundation

public enum NotificationStyle: CaseIterable {
    /// Banners appear in the upper-right corner and go away automatically.
    case banners
    /// Alerts stay on screen until dismissed.
    case alert
    /// Notifications style is not defined.
    case none
    
    var flag: NotificationFlag {
        switch self {
        case .banners:
            return .styleBanners
        case .alert:
            return .styleAlerts
        case .none:
            return NotificationFlag([.styleAlerts, .styleBanners])
        }
    }
    
    static func parseStyle(from flags: NotificationFlag) -> NotificationStyle {
        if flags.contains(alert.flag) {
            return .banners
        } else if flags.contains(banners.flag) {
            return .alert
        }
            
        return .none
    }
}
