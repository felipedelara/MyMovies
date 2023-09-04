//
//  MovieListViewModel.swift
//  MyMovies
//
//  Created by Felipe Lara on 04/09/2023.
//

import Foundation

@MainActor
class MovieListViewModel: ObservableObject {

    enum ViewState {

        case empty
        case loading
        case content([Movie])
        case error(String)
    }

    // MARK: - Published properties
    @Published var state: ViewState = .empty


    // MARK: - Functions
    func populateMovies() async {

        self.state = .loading

        do {
            // Sleep for 1 second. Nicer effect visually
            try await Task.sleep(nanoseconds: 1_000_000_000)

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
