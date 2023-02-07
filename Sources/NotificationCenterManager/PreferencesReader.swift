//
//  PreferencesReader.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import NotificationCenterCore
import ArgumentParser

struct Read: ParsableCommand {
    static let configuration = CommandConfiguration(
        subcommands: [
            Read.Bundle.self,
            Read.Identifiers.self,
        ]
    )
}

extension Read {
    struct Bundle: ParsableCommand {
        @Argument(help: ArgumentHelp(Strings.Arguments.bundleIDValue, discussion: Strings.Arguments.bundleID))
        var bundleID: BundleID
        
        mutating func run() throws {
            let result = try PreferencesManager.shared.provideAppPreferences(for: bundleID)
            _ = result.map { preferences in
                print("""
                    +----------------------------------+----------+
                    | Option                           |   Value  |
                    +----------------------------------+----------+
                    | allow_notifications              |     \(preferences.isNotificationAllowed.int)    |
                    +----------------------------------+----------+
                    | style_banners                    |     \(preferences.isBannersStyle.int)    |
                    | style_alerts                     |     \(preferences.isAlertsStyle.int)    |
                    | style_none                       |     \(preferences.isNoneStyle.int)    |
                    +----------------------------------+----------+
                    | critical_alerts                  |     \(preferences.isCriticalAlertsAllowed.int)    |
                    | badge_app_icon                   |     \(preferences.badgeApplicationIcon.int)    |
                    | sound_notifications              |     \(preferences.soundNotification.int)    |
                    +----------------------------------+----------+
                    | preview_always                   |     \((preferences.previewType == .always).int)    |
                    | preview_default                  |     \((preferences.previewType == .default).int)    |
                    | preview_when_unlocked            |     \((preferences.previewType == .whenUnlocked).int)    |
                    | preview_never                    |     \((preferences.previewType == .never).int)    |
                    +----------------------------------+----------+
                    | grouping_off                     |     \((preferences.groupingStyle == .off).int)    |
                    | grouping_auto                    |     \((preferences.groupingStyle == .automatic).int)    |
                    | grouping_by_app                  |     \((preferences.groupingStyle == .byApplication).int)    |
                    +----------------------------------+----------+
                """)
            }
        }
    }
}
    
extension Read {
    struct Identifiers: ParsableCommand {
        mutating func run() throws {
            let bundleIDs = try PreferencesManager.shared.provideExistingBundleIDs()
            bundleIDs.forEach {
                print($0)
            }
        }
    }
}

extension Bool {
    var int: Int {
        return self ? 1 : 0
    }
}
