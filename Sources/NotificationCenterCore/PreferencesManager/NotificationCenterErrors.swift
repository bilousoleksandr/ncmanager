//
//  NotificationCenterErrors.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import Foundation

public enum NotificationCenterErrors: Error {
    case missingAppPreferences(String)
    case missingFieldForPreferences(String)
}
