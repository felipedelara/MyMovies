//
//  MovieListViewModelTests.swift
//  MyMoviesTests
//
//  Created by Felipe Lara on 04/09/2023.
//

import XCTest
@testable import MyMovies

class MovieListViewModelTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    // MARK: - Tests

    func testPopulateMoviesSuccess() {

        // Arrange
        let apiMock = APIServiceMock(shouldThrowError: false, defaultBoolResults: true)
        let viewModel = MovieListViewModel(apiService: apiMock)
        let expectation = XCTestExpectation(description: "Movies loaded")

        // Act
        Task {
            await viewModel.populateMovies()

            // The view model adds half a second of a loading delay for visual purposes
            try? await Task.sleep(nanoseconds: 1_000_000_000)

            // Assert
            guard case .content(let movies) = viewModel.state else {

                XCTFail("Could not load content state")
                return
            }

            guard let firstMovie = movies.first else {

                XCTFail("Array should not be empty")
                return
            }

            XCTAssertEqual(firstMovie, Movie(adult: false,
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
                                             voteCount: 1234))
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testPopulateMoviesFailure() {

        //Arrange
        let apiMock = APIServiceMock(shouldThrowError: true, defaultBoolResults: true)
        let viewModel = MovieListViewModel(apiService: apiMock)
        let expectation = XCTestExpectation(description: "Movie load with bad API mock throws error")

        // Act:
        Task {
            await viewModel.populateMovies()

            //The view model adds half a second of a loading delay for visual purposes
            try? await Task.sleep(nanoseconds: 1_000_000_000)

            // Assert
            guard case .error(let description) = viewModel.state else {

                XCTFail("Wrong state")
                return
            }

            XCTAssertEqual(description, "The operation couldn’t be completed. (MyMoviesTests.ServiceError error 2.)")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
