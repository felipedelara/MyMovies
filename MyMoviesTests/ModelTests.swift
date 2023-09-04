//
//  ModelTests.swift
//  MyMoviesTests
//
//  Created by Felipe Lara on 04/09/2023.
//

import XCTest
import MyMovies

final class ModelTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testDecodingListResponseModel() throws {

        //Arrange
        guard let jsonURL = Bundle(for: type(of: self)).url(forResource: "ListResponseTest", withExtension: "json") else {
            XCTFail("JSON file not found.")
            return
        }
        let jsonData = try Data(contentsOf: jsonURL)

        //Act
        do {
            let listResponse = try JSONDecoder().decode(ListResponse.self, from: jsonData)

            // Assert
            XCTAssertEqual(listResponse.page, 1)
            XCTAssertEqual(listResponse.totalPages, 1)
            XCTAssertEqual(listResponse.totalResults, 1)
            XCTAssertNotNil(listResponse.results)
            XCTAssertFalse(listResponse.results.isEmpty)
        } catch {

            XCTFail("Error decoding JSON: \(error)")
        }
    }

    func testDecodingMovieModel() throws {

        //Arrange
        guard let jsonURL = Bundle(for: type(of: self)).url(forResource: "ListResponseTest", withExtension: "json") else {
            XCTFail("JSON file not found.")
            return
        }

        //Act
        let jsonData = try Data(contentsOf: jsonURL)

        do {
            let listResponse = try JSONDecoder().decode(ListResponse.self, from: jsonData)

            guard let movie = listResponse.results.first else {

                XCTFail("No movie in JSON")
                return
            }

            // Assert
            XCTAssertEqual(movie.adult, false)
            XCTAssertEqual(movie.backdropPath, "/example_backdrop.jpg")
            XCTAssertEqual(movie.genreIDS, [28, 12, 14])
            XCTAssertEqual(movie.id, 12345)
            XCTAssertEqual(movie.originalLanguage, "en")
            XCTAssertEqual(movie.originalTitle, "Example Movie")
            XCTAssertEqual(movie.overview, "This is an example")
            XCTAssertEqual(movie.popularity, 123.45)
            XCTAssertEqual(movie.posterPath, "/example_poster.jpg")
            XCTAssertEqual(movie.releaseDate, "2023-09-01")
            XCTAssertEqual(movie.title, "Example Movie Title")
            XCTAssertEqual(movie.video, false)
            XCTAssertEqual(movie.voteAverage, 7.8)
            XCTAssertEqual(movie.voteCount, 1234)
        } catch {

            XCTFail("Error decoding JSON: \(error)")
        }
    }
}
