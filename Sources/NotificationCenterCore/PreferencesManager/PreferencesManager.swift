//
//  PreferencesManager.swift
//  
//
//  Created by Oleksandr Bilous on 06.02.2023.
//

import AppKit

public final class PreferencesManager {
    private init() {}
    public static let shared = PreferencesManager()
    
    public func provideExistingBundleIDs() throws -> [BundleID] {
        try preferencesList()
            .compactMap { $0.string(forKey: Constants.Keys.bundleID) }
    }
    
    public func provideAppPreferences(
        for bundleID: BundleID
    ) throws -> Result<AppNotificationPreferences, NotificationCenterErrors> {
        let knownApps = try preferencesList()
        let dict = knownApps.first{ $0.string(forKey: Constants.Keys.bundleID) == bundleID}
        guard let dict = dict  else {
            return .failure(.missingAppPreferences(bundleID))
        }
        
        guard let appPreferences = AppNotificationPreferences(dictionary: dict) else {
            return .failure(.missingFieldForPreferences(bundleID))
        }
        
        return .success(appPreferences)
    }
    
    public func changeNotificationsSettings(
        for bundleID: BundleID?,
        settings: [NotificationSettings]
    ) throws {
        let apps = try preferencesList()
        
        guard let dict = apps.first(where: { $0.string(forKey: Constants.Keys.bundleID) == bundleID }) else {
            throw NotificationCenterErrors.missingFieldForPreferences(bundleID ?? "Missing BundleID")
        }
            
        settings.forEach { option in
            switch option {
            case .showBadgeIcon(let shouldBadge):
                let flag = dict.value(forKey: Constants.Keys.flags) as? Int64 ?? 0
                dict.setValue(test(flag, .badgeAppIcon, isTrue: shouldBadge), forKey: Constants.Keys.flags)
            case .allowSoundNotification(let allowSound):
                let flag = dict.value(forKey: Constants.Keys.flags) as? Int64 ?? 0
                dict.setValue(test(flag, .soundNotification, isTrue: allowSound), forKey: Constants.Keys.flags)
            case .notificationStyle(let notificationStyle):
                let flag = dict.value(forKey: Constants.Keys.flags) as? Int64 ?? 0
                 dict.setValue(test(flag, notificationStyle.flag, isTrue: notificationStyle != .none), forKey: Constants.Keys.flags)
            case .allowNotifications(let isAllowed):
                let flag = dict.value(forKey: Constants.Keys.flags) as? Int64 ?? 0
                dict.setValue(test(flag, .allowNotifications, isTrue: isAllowed), forKey: Constants.Keys.flags)
            case .allowCriticalAlerts(let isAllowed):
                let flag = dict.value(forKey: Constants.Keys.flags) as? Int64 ?? 0
                dict.setValue(test(flag, .criticalAlerts, isTrue: isAllowed), forKey: Constants.Keys.flags)
            case .preview(let type):
                dict.setValue(type.rawValue, forKey: Constants.Keys.contentVisibility)
            case .grouping(let type):
                dict.setValue(type.rawValue, forKey: Constants.Keys.grouping)
            }
        }
                
        CFPreferencesSetAppValue(
            Constants.Keys.apps as CFString,
            apps as NSArray,
            Constants.ncprefsBundleID as CFString
        )
        CFPreferencesAppSynchronize(Constants.ncprefsBundleID as CFString)
        
        NotificationCenterController.relaunch()
    }
    
    private func test(_ flag: Int64, _ newFlag: NotificationFlag, isTrue: Bool) -> Int64 {
        return isTrue ? flag | newFlag.rawValue : flag & ~newFlag.rawValue
    }
    
    private func changeNotificationSettings(
        bundleID: BundleID?,
        flag: Int64,
        preview: NotificationPreviewType? = .none,
        grouping: NotificationGrouping? = .none
    ) throws {
        let apps = try preferencesList().compactMap { app in
            let existingFlag = app.value(forKey: Constants.Keys.flags) as? Int64 ?? 0
            let newFlag = existingFlag & flag
            
            guard let bundleID = bundleID else {
                app.setValue(newFlag, forKey: Constants.Keys.flags)
                preview.flatMap { app.setValue($0.rawValue, forKey: Constants.Keys.contentVisibility) }
                grouping.flatMap { app.setValue($0.rawValue, forKey: Constants.Keys.grouping) }
                return app
            }
            
            if app.string(forKey: Constants.Keys.bundleID) == bundleID {
                app.setValue(newFlag, forKey: Constants.Keys.flags)
                preview.flatMap { app.setValue($0.rawValue, forKey: Constants.Keys.contentVisibility) }
                grouping.flatMap { app.setValue($0.rawValue, forKey: Constants.Keys.grouping) }
            }
            return app
        }
        
        
        CFPreferencesSetAppValue(
            Constants.Keys.apps as CFString,
            apps as NSArray,
            Constants.ncprefsBundleID as CFString
        )
        CFPreferencesAppSynchronize(Constants.ncprefsBundleID as CFString)
    }
    
    private func preferencesList() throws -> [NSDictionary] {
        let plistURL = FileManager.default
            .homeDirectoryForCurrentUser
            .appendingPathComponent("Library/Preferences/\(Constants.ncprefsBundleID).plist")
        let plistInfo = try NSDictionary(contentsOf: plistURL, error: ())
        let apps = plistInfo.object(forKey: Constants.Keys.apps) as? [NSDictionary]
        return apps ?? []
    }
}
