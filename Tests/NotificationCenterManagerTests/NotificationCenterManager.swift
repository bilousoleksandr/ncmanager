//
//  NotificationCenterManagerTests.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import XCTest
@testable import NotificationCenterManager

final class NotificationCenterManagerTests: XCTestCase {
    func testExample() throws {
        let bundleID = "com.apple.Maps"
        NotificationCenterManager.main([
            "write",
            bundleID,
            "--notifications",
            "true",
            "--critical-alert",
            "false",
            "--icon",
            "true",
            "--sound",
            "false",
            "--alert-style",
            "banners",
            "--preview",
            "always",
            "--grouping",
            "off"
        ])
    }
}
