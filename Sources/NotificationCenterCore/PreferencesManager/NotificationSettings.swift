//
//  NotificationSettings.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import Foundation

public enum NotificationSettings {
    case showBadgeIcon(Bool)
    case allowSoundNotification(Bool)
    case notificationStyle(NotificationStyle)
    case allowNotifications(Bool)
    case allowCriticalAlerts(Bool)
    case preview(NotificationPreviewType)
    case grouping(NotificationGrouping)
}
