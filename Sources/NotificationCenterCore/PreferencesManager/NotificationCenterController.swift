//
//  File.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import Foundation

public enum NotificationCenterController {
    public static func relaunch() {
        [
            ShellExecutor(arguments: ["killall", "NotificationCenter"]),
            ShellExecutor(arguments: ["killall", "usernoted"])
        ].forEach { $0.execute() }
    }
}
