//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Nazar on 1/9/24.
//

import SwiftUI
import SwiftData

@main
struct FlashzillaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Card.self)
    }
}
