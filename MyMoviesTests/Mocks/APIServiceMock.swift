//
//  APIServiceMock.swift
//  MyMoviesTests
//
//  Created by Felipe Lara on 04/09/2023.
//

import Foundation

class APIServiceMock: APIServiceType {

    var shouldThrowError: Bool
    var defaultBoolResults: Bool

    init(shouldThrowError: Bool,
         defaultBoolResults: Bool) {

        self.shouldThrowError = shouldThrowError
        self.defaultBoolResults = defaultBoolResults
    }

    func getMovies() async throws -> [Movie] {

        guard shouldThrowError == false else {

            throw ServiceError.genericError
        }

        return [Movie(adult: false,
                      backdropPath: "/example_backdrop.jpg",
                      genreIDS: [28, 12, 14],
                      id: 12345,
                      originalLanguage: "en",
                      originalTitle: "Example Movie",
                      overview: "This is an example",
                      popularity: 123.45,
                      posterPath: "/example_poster.jpg",
                      releaseDate: "2023-09-01",
                      title: "Example Movie Title",
                      video: false,
                      voteAverage: 7.8,
                      voteCount: 1234)]
    }

    func authenticate(apiAccessToken: String) async -> Bool {

        return self.defaultBoolResults
    }
}
