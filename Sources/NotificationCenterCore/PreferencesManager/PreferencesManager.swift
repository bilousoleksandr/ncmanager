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
                dict.setValue(getFlag(flag, .badgeAppIcon, shouldBadge), forKey: Constants.Keys.flags)
            case .allowSoundNotification(let allowSound):
                let flag = dict.value(forKey: Constants.Keys.flags) as? Int64 ?? 0
                dict.setValue(getFlag(flag, .soundNotification, allowSound), forKey: Constants.Keys.flags)
            case .notificationStyle(let notificationStyle):
                let flag = dict.value(forKey: Constants.Keys.flags) as? Int64 ?? 0
                 dict.setValue(getFlag(flag, notificationStyle.flag, notificationStyle != .none), forKey: Constants.Keys.flags)
            case .allowNotifications(let isAllowed):
                let flag = dict.value(forKey: Constants.Keys.flags) as? Int64 ?? 0
                dict.setValue(getFlag(flag, .allowNotifications, isAllowed), forKey: Constants.Keys.flags)
            case .allowCriticalAlerts(let isAllowed):
                let flag = dict.value(forKey: Constants.Keys.flags) as? Int64 ?? 0
                dict.setValue(getFlag(flag, .criticalAlerts, isAllowed), forKey: Constants.Keys.flags)
            case .preview(let type):
                dict.setValue(type.rawValue, forKey: Constants.Keys.contentVisibility)
            case .grouping(let type):
                dict.setValue(type.rawValue, forKey: Constants.Keys.grouping)
            }
        }
                
        saveAppChanges(apps: apps)
    }
    
    public func disableNotifications(for applications: ApplicationType) throws {
        let apps = try preferencesList()
        apps.forEach { app in
            let flag = app.value(forKey: Constants.Keys.flags) as? Int64 ?? 0
            let newFlag = flag & ~NotificationFlag.allowNotifications.rawValue & ~NotificationStyle.none.flag.rawValue
            if applications == .all {
                app.setValue(newFlag, forKey: Constants.Keys.flags)
                return
            }
            
            guard let bundle = app.string(forKey: Constants.Keys.bundleID),
                  bundle.hasPrefix("_SYSTEM_CENTER_") else {
                return
            }
            app.setValue(newFlag, forKey: Constants.Keys.flags)
        }
        
        saveAppChanges(apps: apps)
    }
    
    private func getFlag(_ flag: Int64, _ newFlag: NotificationFlag, _ and: Bool) -> Int64 {
        return and ? flag | newFlag.rawValue : flag & ~newFlag.rawValue
    }
    
    
    private func preferencesList() throws -> [NSDictionary] {
        let plistURL = FileManager.default
            .homeDirectoryForCurrentUser
            .appendingPathComponent("Library/Preferences/\(Constants.ncprefsBundleID).plist")
        let plistInfo = try NSDictionary(contentsOf: plistURL, error: ())
        let apps = plistInfo.object(forKey: Constants.Keys.apps) as? [NSDictionary]
        return apps ?? []
    }
    
    private func saveAppChanges(apps: [NSDictionary]) {
        CFPreferencesSetAppValue(
            Constants.Keys.apps as CFString,
            apps as NSArray,
            Constants.ncprefsBundleID as CFString
        )
        CFPreferencesAppSynchronize(Constants.ncprefsBundleID as CFString)
        NotificationCenterController.relaunch()
    }
}
