//
//  SettingsViewModelTests.swift
//  MyMoviesTests
//
//  Created by Felipe Lara on 04/09/2023.
//

import XCTest
@testable import MyMovies

class SettingsViewModelTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    // MARK: - Tests

    func testAuthenticateSuccess() {

        // Arrange
        let apiMock = APIServiceMock(shouldThrowError: false, defaultBoolResults: true)
        let userDefaultsMock = UserDefaultsManagerMock(shouldReturnSuccessfully: true)
        let viewModel = SettingsViewModel(apiService: apiMock, userDefaultsManager: userDefaultsMock)

        let expectation = XCTestExpectation(description: "Authenticate succeeds")

        // Act
        Task {

            viewModel.attemptSavedToken()
            try? await Task.sleep(nanoseconds: 1_000_000)

            // Assert
            XCTAssertEqual(viewModel.isValidAccessToken, true)
            XCTAssertEqual(viewModel.accessToken, "TestTokenResult")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testAuthenticateFailure() {

        // Arrange
        let apiMock = APIServiceMock(shouldThrowError: true, defaultBoolResults: true)
        let userDefaultsMock = UserDefaultsManagerMock(shouldReturnSuccessfully: false)
        let viewModel = SettingsViewModel(apiService: apiMock, userDefaultsManager: userDefaultsMock)

        let expectation = XCTestExpectation(description: "Authenticate fails")

        // Act
        Task {

            viewModel.attemptSavedToken()
            try? await Task.sleep(nanoseconds: 1_000_000)

            // Assert
            XCTAssertEqual(viewModel.isValidAccessToken, false)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
