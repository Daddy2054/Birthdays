//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Jean on 18/10/24.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
