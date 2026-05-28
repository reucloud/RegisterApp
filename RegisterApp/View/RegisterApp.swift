//
//  RegisterAppApp.swift
//  RegisterApp
//
//  Created by 戸崎悠真 on 2026/05/17.
//

import SwiftUI
import SwiftData

@main
struct RegisterAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Product.self)
    }
}
