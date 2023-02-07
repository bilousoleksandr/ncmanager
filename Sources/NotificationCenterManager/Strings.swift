//
//  Strings.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import Foundation

enum Strings {
    enum Arguments {
        static let bundleID = "Target bundle identifier to change preferences. If not specified, all applications settings will be changes"
        static let bundleIDValue = "Bundle identifier. Example: com.apple.Mail"
        static let showBadgeIcon = "Badge application icon in notifications"
        static let soundNotification = "Allow play sound for notifications"
        static let allowNotifications = "Allow notifications for application"
        static let allowCriticalAlerts = "Allow critical alerts for application"
        static let changeNotificationStyle = "Change style for notifications.\nBanners appear in the upper-right corner and go away automatically.\nAlerts stay on screen until dismissed.\nWhen `none`, notifications style is not defined."
        static let preview = "Define specific preview style for notifications"
        static let grouping = "Notifications grouping style"
        static let previewValue = "Value: 'never', 'always', 'default' or 'whenUnlocked'"
        static let groupingValue = "Value: 'off', 'auto' or 'app'"
        static let boolValue = "Value: 'true' or 'false'"
        static let alertStyleValue = "Value: 'none', 'alerts' or 'banners'"
    }
}
