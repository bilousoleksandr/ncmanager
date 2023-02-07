//
//  NotificationStyle+Extensions.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import NotificationCenterCore
import ArgumentParser

extension NotificationStyle: ExpressibleByArgument {
    var option: String {
        switch self {
        case .banners:
            return "banners"
        case .alert:
            return "alert"
        case .none:
            return "none"
        }
    }
    
    public init?(argument: String) {
        guard let style = NotificationStyle.allCases.first(where: { $0.option == argument }) else {
            return nil
        }
        self = style
    }
}


extension NotificationPreviewType: ExpressibleByArgument {
    var option: String {
        switch self {
        case .default:
            return "default"
        case .never:
            return "never"
        case .whenUnlocked:
            return "whenUnlocked"
        case .always:
            return "always"
        }
    }
    
    public init?(argument: String) {
        guard let style = NotificationPreviewType.allCases.first(where: { $0.option == argument }) else {
            return nil
        }
        self = style
    }
}

extension NotificationGrouping: ExpressibleByArgument {
    var option: String {
        switch self {
        case .automatic:
            return "auto"
        case .byApplication:
            return "app"
        case .off:
            return "off"
        }
    }
    
    public init?(argument: String) {
        guard let style = NotificationGrouping.allCases.first(where: { $0.option == argument }) else {
            return nil
        }
        self = style
    }
}
