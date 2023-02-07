//
//  AppNotificationPreferences.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import Foundation

public typealias BundleID = String

public struct AppNotificationPreferences {
    let bundleID: BundleID
    let flags: NotificationFlag
    let contentVisibility: Int
    let grouping: Int
    
    init?(dictionary: NSDictionary) {
        let bundleID = dictionary.string(forKey: Constants.Keys.bundleID)
        let flags = dictionary.int(forKey: Constants.Keys.flags)
        let contentVisibility = dictionary.int(forKey: Constants.Keys.contentVisibility)
        let grouping = dictionary.int(forKey: Constants.Keys.grouping)
        guard let bundleID = bundleID,
              let flags = flags,
              let contentVisibility = contentVisibility,
              let grouping = grouping else {
            return nil
        }
        self.bundleID = bundleID
        self.flags = NotificationFlag(rawValue: Int64(flags))
        self.contentVisibility = contentVisibility
        self.grouping = grouping
    }
}

// MARK: - ApplicationPreferences

extension AppNotificationPreferences {
    public var groupingStyle: NotificationGrouping? {
        .init(rawValue: grouping)
    }
    
    public var notificationsStyle: NotificationStyle? {
        NotificationStyle.parseStyle(from: flags)
    }
    
    public var isNotificationAllowed: Bool {
        flags.contains(.allowNotifications)
    }
    
    public var isCriticalAlertsAllowed: Bool {
        flags.contains(.criticalAlerts)
    }
    
    public var badgeApplicationIcon: Bool {
        flags.contains(.badgeAppIcon)
    }
    
    public var soundNotification: Bool {
        flags.contains(.soundNotification)
    }
    
    public var previewType: NotificationPreviewType? {
        return .init(rawValue: contentVisibility)
    }
    
    public var isBannersStyle: Bool {
        notificationsStyle == .banners
    }
    
    public var isAlertsStyle: Bool {
        notificationsStyle == .alert
    }
    
    public var isNoneStyle: Bool {
        notificationsStyle == NotificationStyle.none
    }
}
