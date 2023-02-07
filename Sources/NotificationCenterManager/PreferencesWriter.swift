//
//  PreferencesWriter.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import NotificationCenterCore
import ArgumentParser

struct Write: ParsableCommand {
    @Argument(help: ArgumentHelp(Strings.Arguments.bundleIDValue, discussion: Strings.Arguments.bundleID))
    var bundleID: BundleID
    
    @Option(name: .shortAndLong, help: ArgumentHelp(Strings.Arguments.boolValue, discussion: Strings.Arguments.showBadgeIcon))
    var icon: Bool?
    
    @Option(name: .shortAndLong, help: ArgumentHelp(Strings.Arguments.boolValue, discussion: Strings.Arguments.soundNotification))
    var sound: Bool?
    
    @Option(name: .shortAndLong, help: ArgumentHelp(Strings.Arguments.boolValue, discussion: Strings.Arguments.allowNotifications))
    var notifications: Bool?
    
    @Option(name: .shortAndLong, help: ArgumentHelp(Strings.Arguments.boolValue, discussion: Strings.Arguments.allowCriticalAlerts))
    var criticalAlert: Bool?
    
    @Option(name: .shortAndLong, help: ArgumentHelp(Strings.Arguments.alertStyleValue, discussion: Strings.Arguments.changeNotificationStyle))
    var alertStyle: NotificationStyle?
    
    @Option(name: .shortAndLong, help: ArgumentHelp(Strings.Arguments.previewValue, discussion: Strings.Arguments.preview))
    var preview: NotificationPreviewType?
    
    @Option(name: .shortAndLong, help: ArgumentHelp(Strings.Arguments.groupingValue, discussion: Strings.Arguments.grouping))
    var grouping: NotificationGrouping?
    
    mutating func run() throws {
        var options: [NotificationSettings] = []
        icon.flatMap { options.append(.showBadgeIcon($0)) }
        sound.flatMap { options.append(.allowSoundNotification($0)) }
        notifications.flatMap { options.append(.allowNotifications($0)) }
        criticalAlert.flatMap { options.append(.allowCriticalAlerts($0)) }
        alertStyle.flatMap { options.append(.notificationStyle($0)) }
        preview.flatMap { options.append(.preview($0)) }
        grouping.flatMap { options.append(.grouping($0)) }
        try PreferencesManager.shared.changeNotificationsSettings(
            for: bundleID,
            settings: options
        )
    }
}

