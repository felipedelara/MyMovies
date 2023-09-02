//
//  MyMoviesApp.swift
//  MyMovies
//
//  Created by Felipe Lara on 02/09/2023.
//

import SwiftUI

@main
struct MyMoviesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Movies", systemImage: "list.dash")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
