//
//  ContentView.swift
//  MyMovies
//
//  Created by Felipe Lara on 02/09/2023.
//

import SwiftUI
import CoreData

struct MovieListView: View {

    @StateObject private var viewModel = MovieListViewModel()

    var body: some View {

        NavigationView {

            switch viewModel.state {
            case .empty:

                Button("Load Data") {
                    Task {
                        await viewModel.populateMovies()
                    }
                }
                .padding(.horizontal, 20)
                .frame(height: 40.0)
                .buttonStyle(PrimaryButtonStyle())

            case .loading:
                ProgressView("Loading...")

            case .content(let movies):

                List(movies, id: \.id) { movies in
                    Text(movies.originalTitle)
                }.listStyle(.plain)
                    .navigationTitle("Movies")

            case .error(let errorMessage):
                Text("Error: \(errorMessage)")
                    .font(.headline)
                    .foregroundColor(.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

@MainActor
class MovieListViewModel: ObservableObject {

    @Published var state: ViewState = .empty

    enum ViewState {

        case empty
        case loading
        case content([Movie])
        case error(String)
    }

    func populateMovies() async {

        self.state = .loading

        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)// Sleep for 1 second. Nicer effect visually

            let movies = try await APIService().getMovies()

            DispatchQueue.main.async {
                self.state = .content(movies)
            }
        } catch {
            DispatchQueue.main.async {
                self.state = .error(error.localizedDescription)
            }
        }
    }
}
