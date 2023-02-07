//
//  ShellExecutor.swift
//  
//
//  Created by Oleksandr Bilous on 07.02.2023.
//

import Foundation

struct ShellExecutor {
    typealias Argument = String
    let arguments: [Argument]
    
    func execute() {
        let task = Process()
        task.arguments = arguments
        task.launchPath = "/usr/bin/env"
        task.launch()
        task.waitUntilExit()
    }
}
