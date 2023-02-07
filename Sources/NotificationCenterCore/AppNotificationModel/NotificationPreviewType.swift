//
//  NotificationPreviewKind.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import Foundation

public enum NotificationPreviewType: Int, CaseIterable {
    case `default` = 0
    case never = 1
    case whenUnlocked = 2
    case always = 3
}
