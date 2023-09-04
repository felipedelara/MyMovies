//
//  UserDefaultsManagerMock.swift
//  MyMoviesTests
//
//  Created by Felipe Lara on 04/09/2023.
//

import Foundation
@testable import MyMovies

class UserDefaultsManagerMock: UserDefaultsManagerType {

    var shouldReturnSuccessfully: Bool

    init(shouldReturnSuccessfully: Bool) {

        self.shouldReturnSuccessfully = shouldReturnSuccessfully
    }

    func getAccessToken() -> String? {

        guard self.shouldReturnSuccessfully else {

            return nil
        }

        return "TestTokenResult"
    }

    func save(accessToken: String) { }
}
