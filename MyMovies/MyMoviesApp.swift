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

    @AppStorage("isDarkModeEnabled") var isDarkModeEnabled = true

    var body: some Scene {
        WindowGroup {
            MainView()
                .tint(.yellow)
                .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
        }
    }
}

struct MainView: View {

    var body: some View {
        TabView {
            MovieListView()
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
