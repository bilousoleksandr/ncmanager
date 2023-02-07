//
//  AppNotificationModelTests.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import XCTest
@testable import NotificationCenterCore

final class AppNotificationModelTests: XCTestCase {
    func testPositiveFlags() throws {
        // GIVEN
        let flags: NotificationFlag = [
            .badgeAppIcon,
            .soundNotification,
            .styleBanners,
            .allowNotifications,
            .criticalAlerts
        ]
        
        let dict: [String: Any] = [
            Constants.Keys.flags: flags.rawValue,
            Constants.Keys.contentVisibility: 1,
            Constants.Keys.grouping: 1,
            Constants.Keys.bundleID: "bar",
        ]
        
        // WHEN
        let model = try XCTUnwrap(
            AppNotificationPreferences(dictionary: dict as NSDictionary)
        )
        
        // THEN
        XCTAssertTrue(model.badgeApplicationIcon)
        XCTAssertTrue(model.soundNotification)
        XCTAssertTrue(model.isNotificationAllowed)
        XCTAssertTrue(model.isCriticalAlertsAllowed)
        XCTAssertEqual(model.notificationsStyle, .banners)
        XCTAssertEqual(model.groupingStyle, .byApplication)
        XCTAssertEqual(model.previewType, .never)
    }

    func testNegativeFlags() throws {
        // GIVEN
        let flags: NotificationFlag = [
            .badgeAppIcon,
            .soundNotification,
            .styleBanners,
            .styleAlerts,
            .allowNotifications,
            .criticalAlerts
        ]
        
        let dict: [String: Any] = [
            Constants.Keys.flags: ~flags.rawValue,
            Constants.Keys.contentVisibility: 3,
            Constants.Keys.grouping: 0,
            Constants.Keys.bundleID: "baz",
        ]
        
        // WHEN
        let model = try XCTUnwrap(
            AppNotificationPreferences(dictionary: dict as NSDictionary)
        )
        
        // THEN
        XCTAssertFalse(model.badgeApplicationIcon)
        XCTAssertFalse(model.soundNotification)
        XCTAssertFalse(model.isNotificationAllowed)
        XCTAssertFalse(model.isCriticalAlertsAllowed)
        XCTAssertEqual(model.notificationsStyle, NotificationStyle.none)
        XCTAssertEqual(model.groupingStyle, .automatic)
        XCTAssertEqual(model.previewType, .always)
    }

}
