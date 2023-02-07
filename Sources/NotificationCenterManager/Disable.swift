//
//  Disable.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import NotificationCenterCore
import ArgumentParser

struct Disable: ParsableCommand {
    @Option(name: .shortAndLong, help: ArgumentHelp(Strings.Arguments.appsTypeValue, discussion: Strings.Arguments.disableNotifications))
    var appsType: ApplicationType
    
    mutating func run() throws {
        try PreferencesManager.shared.disableNotifications(for: appsType)
    }
}

extension ApplicationType: ExpressibleByArgument {}
