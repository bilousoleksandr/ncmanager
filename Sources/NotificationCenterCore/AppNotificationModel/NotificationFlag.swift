//
//  NotificationFlag.swift
//  
//
//  Created by Oleksandr Bilous on 06.02.2023.
//


import Foundation

struct NotificationFlag: OptionSet {
    let rawValue: Int64
    
    static let badgeAppIcon = NotificationFlag(rawValue: 1 << 1)
    static let soundNotification = NotificationFlag(rawValue: 1 << 2)
    static let styleBanners = NotificationFlag(rawValue: 1 << 3)
    static let styleAlerts = NotificationFlag(rawValue: 1 << 4)
    static let allowNotifications = NotificationFlag(rawValue: 1 << 25)
    static let criticalAlerts = NotificationFlag(rawValue: 1 << 26)
}
