//
//  MovieListViewModel.swift
//  MyMovies
//
//  Created by Felipe Lara on 04/09/2023.
//

import Foundation

class MovieListViewModel: ObservableObject {

    enum ViewState {

        case loading
        case content([Movie])
        case error(String)
    }

    // MARK: - Published properties
    @Published var state: ViewState = .loading

    private var apiService: APIServiceType
    init(apiService: APIServiceType = APIService()) {

        self.apiService = apiService

        Task {

            await self.populateMovies()
        }
    }

    // MARK: - Functions
    func populateMovies() async {

        self.state = .loading

        do {
            // Sleep for 1 second. Nicer effect visually
            try await Task.sleep(nanoseconds: 500_000_000)

            let movies = try await apiService.getMovies()

            DispatchQueue.main.async {
                self.state = .content(movies)
            }
        } catch {

            DispatchQueue.main.async {

                switch error as? ServiceError {
                case .noToken:
                    self.state = .error("No API token found. Please go to Settings and insert one.")
                case .invalidUrl:
                    self.state = .error("An invalid request has been attempted. Please contact support.")
                case .none, .genericError:
                    self.state = .error(error.localizedDescription)
                }
            }
        }
    }
}
