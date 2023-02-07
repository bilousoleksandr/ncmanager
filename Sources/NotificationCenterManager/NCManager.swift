import ArgumentParser
import NotificationCenterCore

@main
struct NCManager: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A utility for managing notification centre preferences.",
        version: "1.0.0",
        subcommands: [
            Read.self,
            Write.self,
            Disable.self
        ]
    )
}
